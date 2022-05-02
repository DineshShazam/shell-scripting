#!bin/bash

# prints the commands and their arguments in the terminal
set -x 
# disable the command excution printing in the terminal 
# set +x

builds_folder="/builds"
build_log="/build_logs/build.log"
build_start_time=$(date +%Y-%m-%d-%H-%M-%S)
base_version="02.02.02"
change_log_version=$base_version

script_success="##SCRIPT SUCCESS##"
script_error="##SCRIPT ERROR##"

if [ "$TOPIC_ARN" == "" ]; then 
   echo "SNS Topic Not Found : $TOPIC_ARN"
fi

# $? prints the status of the executed command
# -eq 0 means success
# This method will receive the command executed as its param and prints is it success or failure
check_error() {
  if [ $? -eq 0 ]; then
    mkdir /build_logs/test_coverage
    cp -rf ./coverage/* /build_logs/test_coverage/
    echo $1 " check_error success!"
  else
    echo $1 " check_error error!"
    echo $script_error

    # trigger SNS email via bash
    status_msg="$(date +%Y-%m-%d-%H-%M-%S):$OPENN_TARGET_ENV-$BUILD_BRANCH: Build error $1"
    sns-notification.sh "$status_msg" $TOPIC_ARN $DEPLOY_REGION
    exit 1
  fi
}

git checkout $BUILD_MERGE_FROM
check_error "git checkout $BUILD_MERGE_FROM"

git status

git checkout $BUILD_BRANCH
check_error "git checkout $BUILD_BRANCH"

git status

git merge $BUILD_MERGE_FROM
check_error "git merge $BUILD_MERGE_FROM"

git status

git pull origin $BUILD_BRANCH
check_error "git pull $BUILD_BRANCH"

git status

git push origin $BUILD_BRANCH
check_error "git push $BUILD_BRANCH"

git status

REVISION=`git log -n 1 --pretty=format:"%H"`

repl="revision_#"$REVISION"#"

releases_folder="$builds_folder/releases/$OPENN_TARGET_ENV"
mkdir -p $releases_folder
check_error "check error mkdir $releases_folder"

RELEASE_FILE="$releases_folder/$OPENN_TARGET_ENV_$BUILD_BRANCH_$build_start_time""_revision.zip"

status_msg="$(date +%Y-%m-%d-%H-%M-%S):$OPENN_TARGET_ENV-$BUILD_BRANCH: Build started"
sns-notification.sh "$status_msg" $TOPIC_ARN $DEPLOY_REGION

# fetch secrets from secret manager and export to env 
cd $builds_folder/go/src/github.com/openn-re/openn_dev/server/fw/tools/load_env_secret_keys

if [ "$SECRET_MANAGER_NAME" != "" ]; then
   go run load_env_secret_keys.go $SECRET_MANAGER_NAME $DEPLOY_REGION "build_script" "false"
   check_error "go run load_env_secret_keys.go $SECRET_MANAGER_NAME $DEPLOY_REGION 'build_script' 'false'"
else 
   echo "Secret Manager Not Found.."
   exit 1
fi

cd $builds_folder/go/src/github.com/openn-re/openn_dev/webapp
# check if file exist
if [ -f .env ]; then 
   if [ "$LOAD_ENV" == "ca" ] || [ "$LOAD_ENV" == "anz" ]; then
      echo "IS_PRODN_ENV=true" >> .env
      echo "googleTagManagerEnv=$LOAD_ENV" >> .env
   else
      echo "IS_PRODN_ENV=false" >> .env
   fi
   # export all the key and value in the .env file to environmental variable    
   export $(grep -v '^#.*' .env | xargs)
   echo "ENV File created"
else 
   echo "Failed to Create ENV File"
   exit 1
fi

echo "Setting build timestamp to: "$build_start_time
sed -i "s|#BUILD_DATE#|$build_start_time|g" ./webapp/webpack.config.prod.js
check_error "update build build number in webpack.config.prod.js"

# generating zip file
echo "Build end, starting zip..."

temp_file=$RELEASE_FILE".tmp"

zip -r $temp_file . -x "*/node_modules/*" -x ".git/*"
check_error "zip files and folders"

mv $temp_file $RELEASE_FILE

# uploading zip file to s3
s3prfx="s3://$OPENN_BUILD_BUCKET/$OPENN_TARGET_ENV/$OPENN_TARGET_ENV""_""$BUILD_BRANCH""_"
aws_file_name=$s3prfx${RELEASE_FILE#"$releases_folder/"}
aws s3 cp $RELEASE_FILE $aws_file_name
check_error "aws s3 cp $aws_file_name"
echo " Build Zip File : $OPENN_TARGET_ENV""_""$BUILD_BRANCH""_"" "
echo "Release zipfile ready : $aws_file_name "

# switch statement example
   case $OPENN_BUILD_ENV in
     bngs)
          cdn_id="E26UTTDM17EE0M"
          ;;
     dev2)
          cdn_id="E9RFDINEN7X0K"
          ;;
     stage2)
          cdn_id="E2IHMADR6CLOOS"
          ;;
     *)
          echo "CDN not being cleared for $RUN_ENV_NAME"
          ;;
   esac

# keeping container alive
echo $script_success


status_msg="$(date +%Y-%m-%d-%H-%M-%S):$RUN_ENV_NAME: Deployment completed"
$builds_folder/go/src/github.com/openn-re/openn_dev/server/tools/CDK/docker/utils/deployment_notification "$status_msg" $TOPIC_ARN $DEPLOY_REGION

start_time=$(date +%s.%N)
echo "Server initialization completed at: "$start_time
echo "Keeping container alive for: "$fullpath" ..."

while true
do
    sleep 600
	cur_time=$(date +%s.%N)
	dt=$(echo "$cur_time - $start_time" | bc)
	dd=$(echo "$dt/86400" | bc)
	dt2=$(echo "$dt-86400*$dd" | bc)
	dh=$(echo "$dt2/3600" | bc)
	dt3=$(echo "$dt2-3600*$dh" | bc)
	dm=$(echo "$dt3/60" | bc)
	ds=$(echo "$dt3-60*$dm" | bc)

	echo "Still running release env $RUN_ENV_NAME ... : "$fullpath
	printf "Total run duration: %d:%02d:%02d:%02.4f\n" $dd $dh $dm $ds
done