#!/bin/sh
set -e

sudo pip install docker-compose
eval $(aws ecr get-login --region $CI_AWS_ACTIVE_REGION)

docker-compose up -d

curl --retry 10 --retry-delay 5 127.0.0.1:$(docker-compose port $CI_AWS_ECR_REPO 80 | cut -d ":" -f "2")/fpm_ping | grep "pingpong"

docker stop $(docker ps -a -q)
