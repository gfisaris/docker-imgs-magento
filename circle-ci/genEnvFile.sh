#!/bin/sh
set -e

DOCKER_IMG_TAG=$1

DB_HOST=$CI_PROJECT_NAME"_int"
DB_NAME=$CI_PROJECT_NAME"_db"
DB_ADMINNAME=$CI_PROJECT_NAME"_admin"
DB_ADMINPASS="$CI_MAG_DB_ADMINPASS"
ENV_BASE_SHARED_FOLDER=$CI_PROJECT_NAME"/env/int/"


cat <<EOF > .env
## AutoGenerated Docker-Compose .env File (based on Project and Environement)"

DOCKER_IMG_TAG=$DOCKER_IMG_TAG

AWS_ACCOUNT_ID=$CI_AWS_ACCOUNT_ID
AWS_ECS_REGION=$CI_AWS_ACTIVE_REGION

DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
DB_ADMINNAME=$DB_ADMINNAME
DB_ADMINPASS=$DB_ADMINPASS

DB_TYPE
DB_MODEL
DB_PREFIX
DB_PDO_TYPE
DB_INIT_STM

MGT_KEY
MGT_DATE
MGT_ADMIN_URL
MGT_SESSION_STORAGE

ENV_BASE_SHARED_FOLDER=$ENV_BASE_SHARED_FOLDER
EOF
