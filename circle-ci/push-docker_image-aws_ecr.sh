#!/usr/bin/env bash

# more bash-friendly output for jq
JQ="jq --raw-output --exit-status"

configure_aws_cli(){
	aws --version
	aws configure set default.region eu-central-1
	aws configure set default.output json
}

push-dckimg2awsecr(){
	eval $(aws ecr get-login --region $AWS_REGION)
	docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/my_app:$CIRCLE_SHA1
}

#configure_aws_cli
#push-dckimg2awsecr
