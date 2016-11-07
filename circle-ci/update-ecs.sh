#!/usr/bin/env bash

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

# All Variables

WORKING_FOLDER="~/deployment.ws"
GITHUB_IAC_TF_AWS_ECS="gfisaris/iac-terraform-aws-ecs"

AWS_ECS_CLUSTER="my_cluster--$CIRCLE_SHA1"
AWS_ECS_SERVICE="my_service-$CIRCLE_SHA1"

AWS_ECS_TASK="my_task-$CIRCLE_SHA1"
AWS_ECS_TASK_DEFINITION="my_taskdef-$CIRCLE_SHA1"

AWS_ECS_SERVICE_ALB="my_app-$CIRCLE_SHA1"


prepare-workspace() {
  mkdir -p $WORKING_FOLDER
}

gitclone-iac_aws_ecs() {
  mkdir -p $WORKING_FOLDER/$GITHUB_IAC_TF_AWS_ECS
  cd $WORKING_FOLDER/$GITHUB_IAC_TF_AWS_ECS
  git clone git@github.com:$GITHUB_IAC_TF_AWS_ECS.git .
}

gitpush-iac_aws_ecs() {
  cd $WORKING_FOLDER/$GITHUB_IAC_TF_AWS_ECS
  git add --all
  git commit -m "$1"
  git push
}

create-iac_aws_ecs_task() {
  cd $WORKING_FOLDER/$GITHUB_IAC_TF_AWS_ECS
  cp tasks/task.json.tpl tasks/$AWS_ECS_TASK.json
  sed -i "s/DCK_IMG_NAME/my_app/g" tasks/$AWS_ECS_TASK.json
  sed -i "s/DCK_IMG_TAG/$CIRCLE_SHA1/g" tasks/$AWS_ECS_TASK.json
  gitpush-iac_aws_ecs "Adding new ECS Task: $AWS_ECS_TASK"
}

create-iac_aws_ecs_taskdefinition() {
  cd $WORKING_FOLDER/$GITHUB_IAC_TF_AWS_ECS
  cp task_definitions/taskdefinition.tf.tpl task_definitions/$AWS_ECS_TASK_DEFINITION.tf
  sed -i "s/AWS_ECS_TASK/$AWS_ECS_TASK/g" task_definitions/$AWS_ECS_TASK_DEFINITION.tf
  sed -i "s/AWS_ECS_TASK_DEFINITION/$AWS_ECS_TASK_DEFINITION/g" task_definitions/$AWS_ECS_TASK_DEFINITION.tf
  gitpush-iac_aws_ecs "Adding new ECS Task Definition: $AWS_ECS_TASK_DEFINITION"
}

create-iac_aws_ecs_service() {
  cd $WORKING_FOLDER/$GITHUB_IAC_TF_AWS_ECS
  cp services/service.tf.tpl services/$AWS_ECS_SERVICE.json
  sed -i "s/AWS_ECS_SERVICE/$AWS_ECS_SERVICE/g" services/$AWS_ECS_SERVICE.json
  sed -i "s/AWS_ECS_SERVICE_ALB/$AWS_ECS_SERVICE_ALB/g" services/$AWS_ECS_SERVICE.json
  sed -i "s/AWS_ECS_TASK_DEFINITION/$AWS_ECS_TASK_DEFINITION/g" services/$AWS_ECS_SERVICE.json
  gitpush-iac_aws_ecs "Adding new ECS Service: $AWS_ECS_SERVICE"
}


gitclone-iac_aws_ecs
create-iac_aws_ecs_task
create-iac_aws_ecs_taskdefinition
create-iac_aws_ecs_service
