#!/bin/sh
set -e

AWS_ECS_SERVICE_NAME=$CI_PROJECT_NAME"_"$PRJ_ENV

ecs-cli configure --profile default --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --compose-project-name-prefix $AWS_ECS_SERVICE_NAME || exit 1
ecs-cli compose --project-name $CIRCLE_BUILD_NUM --file ecs-DockerCompose.yml create || exit 1
