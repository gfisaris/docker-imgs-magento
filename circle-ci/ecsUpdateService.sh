#!/bin/sh
set -e

awsAccountID=$1
ecsRegion=$2
ecsCluster=$3
ecsService=$4
ecsTaskDef=$5

ecsOldTaskD=$(aws ecs describe-services --region $ecsRegion --cluster $ecsCluster --service $ecsService | jq -r '.services[] | .taskDefinition')

aws ecr get-login --region $ecsRegion || exit 1
aws ecs describe-services --region $ecsRegion --cluster $ecsCluster --service $ecsService || exit 1

aws ecs update-service --region $ecsRegion --cluster $ecsCluster --service $ecsService --task-definition $ecsTaskDef || exit 1
  echo "Service TaskDefinition Update has started!"
  echo "Current TaskDefinition:" $ecsOldTaskD
  echo "Deploying TaskDefinition:" $ecsTaskDef

getDesiredCount="aws ecs describe-services --region $ecsRegion --cluster $ecsCluster --service $ecsService | jq '.services[].deployments[] | select(.taskDefinition | contains (\"$ecsTaskDef\")) | .desiredCount'"
getRunningCount="aws ecs describe-services --region $ecsRegion --cluster $ecsCluster --service $ecsService | jq '.services[].deployments[] | select(.taskDefinition | contains (\"$ecsTaskDef\")) | .runningCount'"

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
  echo "Service TaskDefinition Update has successfully completed!"
