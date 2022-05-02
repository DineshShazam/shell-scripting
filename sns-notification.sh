message="$1"
subject="[fargate] $1"
sns_topic=$2
region=$3

if [ "$message" == "" ]; then
   echo "Input message is required"
   exit 1
fi;

if [ "$sns_topic" == "" ]; then
   echo "sns topic is required"
   exit 1
fi;

# sns notification for cdk to check build and run errors 
aws --region $region sns publish --topic-arn "$sns_topic" --message "$message" --subject "$subject"

