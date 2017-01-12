#!/bin/sh
set -e

AWS_ECS_SERVICE_NAME=$CI_PROJECT_NAME"_"$PRJ_ENV
AWS_ECS_LIVE_TASKDF=$(aws ecs describe-services --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_NAME | jq -r '.services[] | .taskDefinition')
AWS_ECS_UPDT_TASKDFN=$CI_PROJECT_NAME"_"$PRJ_ENV"_"$CIRCLE_BUILD_NUM

aws ecr get-login --region $CI_AWS_ACTIVE_REGION || exit 1
aws ecs describe-services --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_NAME || exit 1

aws ecs update-service --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_NAME --task-definition $AWS_ECS_UPDT_TASKDFN || exit 1
  echo "Service TaskDefinition Update has started!"
  echo "Current TaskDefinition:" $AWS_ECS_LIVE_TASKDF
  echo "Deploying TaskDefinition:" $AWS_ECS_UPDT_TASKDFN

getDesiredCount="aws ecs describe-services --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_NAME | jq '.services[].deployments[] | select(.taskDefinition | contains (\"$AWS_ECS_UPDT_TASKDFN\")) | .desiredCount'"
getRunningCount="aws ecs describe-services --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_NAME | jq '.services[].deployments[] | select(.taskDefinition | contains (\"$AWS_ECS_UPDT_TASKDFN\")) | .runningCount'"

if [[ $(eval $getDesiredCount) = 0 ]];
  then
    echo "Service Desired Count is set to 0." && exit 1
fi

  while [ $(eval $getDesiredCount) != $(eval $getRunningCount) ];
    do
      echo "Service Tasks Desired Count:" $(eval $getDesiredCount)
      echo "Updated Tasks Running Count:" $(eval $getRunningCount)
      echo "Service TaskDefinition Update is still in progress.."; sleep 5;
  done
  echo "Service Tasks Desired Count:" $(eval $getDesiredCount)
  echo "Updated Tasks Running Count:" $(eval $getRunningCount)
  echo "Service TaskDefinition Update has successfully completed!"
