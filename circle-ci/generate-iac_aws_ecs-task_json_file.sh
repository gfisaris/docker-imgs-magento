#!/usr/bin/env bash

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

ECS_CLUSTER_NAME=$1
ECS_SERVICE_NAME=$2
ECS_TASKDEFINITION_NAME=$3
ECS_TASKDEFINITION_REVISION=$4
UPD_ECS_CONTAINER_NAME=$5
UPD_ECS_CONTAINER_IMAGE=$6
UPD_ECS_CONTAINER_IMAGE_TAG=$7

echo "CLUSTER_NAME: "$ECS_CLUSTER_NAME
echo "ECS_SERVICE_NAME: "$ECS_SERVICE_NAME
echo "ECS_TASKDEFINITION_NAME: "$ECS_TASKDEFINITION_NAME
echo "ECS_TASKDEFINITION_REVISION: "$ECS_TASKDEFINITION_REVISION
echo "ECS_CONTAINER_NAME TO BE UPDATED: "$UPD_ECS_CONTAINER_NAME
echo "ECS_CONTAINER_IMAGE TO BE UPDATED: "$UPD_ECS_CONTAINER_IMAGE
echo "ECS_CONTAINER_IMAGE_TAG TO BE UPDATED: "$UPD_ECS_CONTAINER_IMAGE_TAG


getContainerImage(){
  echo $(aws ecs describe-task-definition --task-definition $ECS_TASKDEFINITION_NAME:$ECS_TASKDEFINITION_REVISION \
        | jq --raw-output --exit-status '.taskDefinition.containerDefinitions[] | select(.name=='\"$1\"')' \
        | jq --raw-output --exit-status '.image' | awk -F: '{print $1}')
}

getContainerImageTag(){
  echo $(aws ecs describe-task-definition --task-definition $ECS_TASKDEFINITION_NAME:$ECS_TASKDEFINITION_REVISION \
        | jq --raw-output --exit-status '.taskDefinition.containerDefinitions[] | select(.name=='\"$1\"')' \
        | jq --raw-output --exit-status '.image' | awk -F: '{print $2}')
}


NGINX_CNT_NAME="nginx"
NGINX_CNT_IMAGE=$(getContainerImage "$NGINX_CNT_NAME")
NGINX_CNT_IMGTAG=$(getContainerImageTag $NGINX_CNT_NAME)

PHPFPM_CNT_NAME="php-fpm"
PHPFPM_CNT_IMAGE=$(getContainerImage "$PHPFPM_CNT_NAME")
PHPFPM_CNT_IMGTAG=$(getContainerImageTag "$PHPFPM_CNT_NAME")

APPCODE_CNT_NAME="app-code"
APPCODE_CNT_IMAGE=$(getContainerImage "$APPCODE_CNT_NAME")
APPCODE_CNT_IMGTAG=$(getContainerImageTag "$APPCODE_CNT_NAME")

echo "$NGINX_CNT_NAME-$NGINX_CNT_IMAGE:$NGINX_CNT_IMGTAG"
echo "$PHPFPM_CNT_NAME-$PHPFPM_CNT_IMAGE:$PHPFPM_CNT_IMGTAG"
echo "$APPCODE_CNT_NAME-$APPCODE_CNT_IMAGE:$APPCODE_CNT_IMGTAG"


if [[ "$UPD_ECS_CONTAINER_NAME" == "nginx" ]]; then
  echo "Update NGINX Container Image Name and Tag"
  NGINX_CNT_IMAGE=$UPD_ECS_CONTAINER_IMAGE
  NGINX_CNT_IMGTAG=$UPD_ECS_CONTAINER_IMAGE_TAG
fi

if [[ "$UPD_ECS_CONTAINER_NAME" == "php-fpm" ]]; then
  echo "Update PHP-FPM Container Image Name and Tag"
  PHPFPM_CNT_IMAGE=$UPD_ECS_CONTAINER_IMAGE
  PHPFPM_CNT_IMGTAG=$UPD_ECS_CONTAINER_IMAGE_TAG
fi

if [[ "$UPD_ECS_CONTAINER_NAME" == "app-code" ]]; then
  echo "Update APP-CODE Container Image Name and Tag"
  APPCODE_CNT_IMAGE=$UPD_ECS_CONTAINER_IMAGE
  APPCODE_CNT_IMGTAG=$UPD_ECS_CONTAINER_IMAGE_TAG
fi
