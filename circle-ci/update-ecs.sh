#!/usr/bin/env bash

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

prepare-workspace() {
  mkdir -p ~/deployment.ws
}

gitclone-iac_aws_ecs() {
  mkdir -p ~/deployment.ws/iac-terraform-aws-ecs
  cd ~/deployment.ws/iac-terraform-aws-ecs
  git clone git@github.com:gfisaris/iac-terraform-aws-ecs.git .
}

gitpush-iac_aws_ecs() {
  cd ~/deployment.ws/iac-terraform-aws-ecs
  git add --all
  git commit -m "Adding new ECS TaskDefinition: lep_stack-$CIRCLE_SHA1"
  git push
}

create-iac_aws_ecs_taskdef() {
  cd ~/deployment.ws/iac-terraform-aws-ecs
  cp tasks/lep_stack.json.tpl tasks/lep_stack-$CIRCLE_SHA1.json
  sed -i 's/DCK_IMG_NAME/my_app/g' tasks/lep_stack-$CIRCLE_SHA1.json
  sed -i 's/DCK_IMG_TAG/$CIRCLE_SHA1/g' tasks/lep_stack-$CIRCLE_SHA1.json
}

gitclone-iac_aws_ecs
create-iac_aws_ecs_taskdef
gitpush-iac_aws_ecs
