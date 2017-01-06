#!/bin/sh
set -e

awsAccountID=$1
ecsRegion=$2
ecrRepository=$3
ciBuildID=$4

aws ecr get-login --region $ecsRegion || exit 1
docker tag $awsAccountID.dkr.ecr.eu-west-1.amazonaws.com/$ecrRepository:$ciBuildID $awsAccountID.dkr.ecr.eu-west-1.amazonaws.com/$ecrRepository:latest || exit 1
docker push $awsAccountID.dkr.ecr.eu-west-1.amazonaws.com/$ecrRepository:$ciBuildID || exit 1
docker push $awsAccountID.dkr.ecr.eu-west-1.amazonaws.com/$ecrRepository:latest || exit 1
