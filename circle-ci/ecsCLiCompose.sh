#!/bin/sh
set -e

ecsRegion=$1
ecsCluster=$2
ecsService=$3
ciBuildID=$4

ecs-cli configure --profile default --region $ecsRegion --cluster $ecsCluster --compose-project-name-prefix $ecsService_ || exit 1
ecs-cli compose --project-name $ciBuildID -file ecs-DockerCompose.yml create || exit 1
