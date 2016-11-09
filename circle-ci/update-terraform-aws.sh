#!/usr/bin/env bash

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

##-- All Variables --##

#APPLICATION="myapp"
#ENVIRONMENT="stg"

  # GitHub.com Repos
  LOCAL_GIT_FOLDER=".myGitRepos"
  GITHUB_IAC_TF_AWS_ECS="gfisaris/iac-terraform-aws-ecs"
  GITHUB_IAC_TF_AWS_EC2_ALB="gfisaris/iac-terraform-aws-ec2-alb"

  # AWS ECS
  AWS_ECS_CLUSTER="$CIRCLE_SHA1"
  AWS_ECS_SERVICE="$APP-${$CIRCLE_SHA1:0:7}"
  AWS_ECS_TASK="$CIRCLE_SHA1"
  AWS_ECS_TASKDEFINITION="$CIRCLE_SHA1"

  # AWS EC2-ALB
  AWS_EC2_ALB="$APP-${$CIRCLE_SHA1:0:7}"
  AWS_EC2_ALB_TG="ecs_cls-$APP-${$CIRCLE_SHA1:0:7}"
  AWS_EC2_ALB_TG_PRT="80"
  AWS_EC2_ALB_TG_PRTCL="HTTP"
  AWS_EC2_ALB_LST_PRT="80"
  AWS_EC2_ALB_LST_PRTCL="HTTP"

##-- All Functions --##

gitprepare() {
  git config --global user.name "Georgios Fysaris"
  git config --global user.email gfisaris@gmail.com
  mkdir -p ~/$LOCAL_GIT_FOLDER
}

gitclone() {
  mkdir -p ~/$LOCAL_GIT_FOLDER/$1
  cd ~/$LOCAL_GIT_FOLDER/$1
  git clone git@github.com:$1.git .
}

gitpush() {
  git add --all
  git commit -m "$1"
  git push
}

create-iac_aws_ecs_task() {
  cp tasks/task.json.tpl tasks/$AWS_ECS_TASK.json
  sed -i "s/DCK_IMG_NAME/my_app/g" tasks/$AWS_ECS_TASK.json
  sed -i "s/DCK_IMG_TAG/$CIRCLE_SHA1/g" tasks/$AWS_ECS_TASK.json
  gitpush "Adding new ECS Task: $AWS_ECS_TASK"
}

create-iac_aws_ecs_taskdefinition() {
  cp task_definitions/taskdefinition.tf.tpl task_definitions/$AWS_ECS_TASKDEFINITION.tf
  sed -i "s/AWS_ECS_TASK/$AWS_ECS_TASK/g" task_definitions/$AWS_ECS_TASKDEFINITION.tf
  sed -i "s/AWS_ECS_TASKDEFINITION/$AWS_ECS_TASKDEFINITION/g" task_definitions/$AWS_ECS_TASKDEFINITION.tf
  gitpush "Adding new ECS Task Definition: $AWS_ECS_TASKDEFINITION"
}

create-iac_aws_ecs_service() {
  cp services/service.tf.tpl services/$AWS_ECS_SERVICE.tf
  sed -i "s/AWS_EC2_ALB_TG/$AWS_EC2_ALB_TG/g" services/$AWS_ECS_SERVICE.tf
  sed -i "s/AWS_ECS_SERVICE/$AWS_ECS_SERVICE/g" services/$AWS_ECS_SERVICE.tf
  sed -i "s/AWS_ECS_TASKDEFINITION/$AWS_ECS_TASKDEFINITION/g" services/$AWS_ECS_SERVICE.tf
  gitpush "Adding new ECS Service: $AWS_ECS_SERVICE"
}

create-iac_aws_ec2_alb_targetgroup() {
  cp alb-targetgroups/targetgroup.tf.tpl alb-targetgroups/$AWS_EC2_ALB_TG.tf
  sed -i "s/AWS_EC2_ALB_TG/$AWS_EC2_ALB_TG/g" alb-targetgroups/$AWS_EC2_ALB_TG.tf
  sed -i "s/AWS_EC2_ALB_TG_PRT/$AWS_EC2_ALB_TG_PRT/g" alb-targetgroups/$AWS_EC2_ALB_TG.tf
  sed -i "s/AWS_EC2_ALB_TG_PRTCL/$AWS_EC2_ALB_TG_PRTCL/g" alb-targetgroups/$AWS_EC2_ALB_TG.tf
  gitpush "Adding new AWS EC2 ALB TargetGroup: $AWS_EC2_ALB_TG"
}

create-iac_aws_ec2_alb_listener() {
  cp alb-listeners/listener.tf.tpl alb-listeners/$AWS_EC2_ALB_LST_PRTCL-$AWS_EC2_ALB_LST_PRT-$CIRCLE_SHA1.tf
  sed -i "s/AWS_EC2_ALB/$AWS_EC2_ALB/g" alb-listeners/$AWS_EC2_ALB_LST_PRTCL-$AWS_EC2_ALB_LST_PRT-$CIRCLE_SHA1.tf
  sed -i "s/AWS_EC2_ALB_TG/$AWS_EC2_ALB_TG/g" alb-listeners/$AWS_EC2_ALB_LST_PRTCL-$AWS_EC2_ALB_LST_PRT-$CIRCLE_SHA1.tf
  sed -i "s/AWS_EC2_ALB_LST_PRT/$AWS_EC2_ALB_LST_PRT/g" alb-listeners/$AWS_EC2_ALB_LST_PRTCL-$AWS_EC2_ALB_LST_PRT-$CIRCLE_SHA1.tf
  sed -i "s/AWS_EC2_ALB_LST_PRTCL/$AWS_EC2_ALB_LST_PRTCL/g" alb-listeners/$AWS_EC2_ALB_LST_PRTCL-$AWS_EC2_ALB_LST_PRT-$CIRCLE_SHA1.tf
  gitpush "Adding new AWS EC2 ALB Listener: $AWS_EC2_ALB_LST_PRTCL-$AWS_EC2_ALB_LST_PRT"
}

create-iac-aws_ec2_alb() {
  cp apploadbalancers/alb.tf.tpl apploadbalancers/$AWS_EC2_ALB.tf
  sed -i "s/AWS_EC2_ALB/$AWS_EC2_ALB/g" apploadbalancers/$AWS_EC2_ALB.tf
  gitpush "Adding new AWS EC2 ALB: $AWS_EC2_ALB"
}

##-- WorkFlow.. --##
pwd && ls -all
gitprepare
gitclone $GITHUB_IAC_TF_AWS_ECS
create-iac_aws_ecs_task
create-iac_aws_ecs_taskdefinition
create-iac_aws_ecs_service
gitclone $GITHUB_IAC_TF_AWS_EC2_ALB
create-iac_aws_ec2_alb_targetgroup
create-iac_aws_ec2_alb_listener
create-iac-aws_ec2_alb
