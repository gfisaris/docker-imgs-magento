#!/bin/sh
set -e

DEPLOYMENT_ENV=$1
AWS_ECS_SERVICE_NAME=$CI_PROJECT_NAME"_"$DEPLOYMENT_ENV"_"

ecs-cli configure --profile default --region $CI_AWS_ACTIVE_REGION --cluster $CI_AWS_ECS_CLUSTER --compose-project-name-prefix $AWS_ECS_SERVICE_NAME || exit 1
ecs-cli compose --project-name $CIRCLE_BUILD_NUM --file docker-compose.yml create || exit 1
