#!/bin/sh
set -e

aws ecr get-login --region $CI_AWS_ACTIVE_REGION || exit 1
docker tag $CI_AWS_ACCOUNT_ID.dkr.ecr.$CI_AWS_ACTIVE_REGION.amazonaws.com/$CI_AWS_ECR_REPO:$CIRCLE_BUILD_NUM $CI_AWS_ACCOUNT_ID.dkr.ecr.$CI_AWS_ACTIVE_REGION.amazonaws.com/$CI_AWS_ECR_REPO:latest || exit 1
docker push $CI_AWS_ACCOUNT_ID.dkr.ecr.$CI_AWS_ACTIVE_REGION.amazonaws.com/$CI_AWS_ECR_REPO:$CIRCLE_BUILD_NUM || exit 1
docker push $CI_AWS_ACCOUNT_ID.dkr.ecr.$CI_AWS_ACTIVE_REGION.amazonaws.com/$CI_AWS_ECR_REPO:latest || exit 1
