#!/bin/bash
set -x

builds_folder="/builds"
build_log="/build_logs/build.log"

mkdir /build_logs

script_success="##SCRIPT SUCCESS##"
script_error="##SCRIPT ERROR##"

check_error() {

  if [ $? -eq 0 ]; then
    echo $1 " check_error success!"
  else
    echo $1 " check_error error!"
    echo $script_errror
    exit 1
  fi
}


date | tee -a $build_log

rm -rf $builds_folder/go

echo '

alias opn="cd /builds/go/src/github.com/openn-re/openn_dev"
alias cdkv2="cd /builds/go/src/github.com/openn-re/openn_dev/server/tools/CDK"

' >>  ~/.bashrc

source ~/.bashrc

# Downoad code
mkdir -p $builds_folder/go/src/github.com/openn-re
cd $builds_folder/go/src/github.com/openn-re
pwd

aws --version

# Download code

git clone https://$OPENN_BUILD_USER:$OPENN_BUILD_PWD@github.com/openn-re/openn_dev.git && echo "openn_dev cloned"

cd $builds_folder/go/src/github.com/openn-re/openn_dev
check_error "cd to $builds_folder/go/src/github.com/openn-re/openn_dev"

# first checkout from develop branch
git checkout develop

git config --global user.name "$OPENN_BUILD_USER"

git config --global user.email $OPENN_BUILD_EMAIL 

# starting docker daemon 
service docker start 

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

