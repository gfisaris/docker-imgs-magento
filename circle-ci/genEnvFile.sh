#!/bin/sh
set -e

DOCKER_IMG_TAG=$1

DB_HOST=$CI_PROJECT_NAME"_int"
DB_NAME=$CI_PROJECT_NAME"_db"
DB_ADMINNAME=$CI_PROJECT_NAME"_admin"
DB_ADMINPASS="$CI_MAG_DB_ADMINPASS"
ENV_BASE_SHARED_FOLDER="/mnt/efs.mounts/ecs_common/services/"$CI_PROJECT_NAME"/env/int/"


cat <<EOF > .env
## AutoGenerated Docker-Compose .env File (based on Project and Environement)"

DOCKER_IMG_TAG=$DOCKER_IMG_TAG

AWS_ACCOUNT_ID=$CI_AWS_ACCOUNT_ID
AWS_ACTIVE_REGION=$CI_AWS_ACTIVE_REGION

DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
DB_ADMINNAME=$DB_ADMINNAME
DB_ADMINPASS=$DB_ADMINPASS

DB_TYPE=goDBTYPE
DB_MODEL=goDBMODEL
DB_PREFIX=goDBPREFIX
DB_PDO_TYPE=goDBPDOTYPE
DB_INIT_STM=goDBINITSTM

MGT_KEY=gogoMGTKEY
MGT_DATE=01/01/1234
MGT_ADMIN_URL=gogopanel
MGT_SESSION_STORAGE=redis-server

ENV_BASE_SHARED_FOLDER=$ENV_BASE_SHARED_FOLDER
EOF

cat .env
