#!/bin/sh
set -e

CODEBASE_DCKIMG_TAG=$1
DEPLOYMENT_ENV=$2

PROJECT_CODENAME=$CI_PROJECT_CODENAME

AWS_ACCOUNT_ID=$CI_AWS_ACCOUNT_ID
AWS_ACTIVE_REGION=$CI_AWS_ACTIVE_REGION

MGT_DB_HOST=$CI_PROJECT_NAME"_"$DEPLOYMENT_ENV
MGT_DB_NAME=$CI_PROJECT_NAME"_db"
MGT_DB_TBL_PRF=""

MGT_DB_ADMINNAME=$CI_PROJECT_CODENAME"_admin"
MGT_DB_ADMINPASS="$CI_MAG_DB_ADMINPASS"

MGT_DB_TYPE="pdo_mysql"
MGT_DB_MODEL="mysql4"
MGT_DB_PDO_TYPE=""
MGT_DB_INIT_STM="SET NAMES utf8"

MGT_DATE="Thu, 07 Jan 2016 16:38:51 +0000"
MGT_CRKEY="f2dfd0bbb6368085a1659995b8322190"
MGT_ADMIN_URL="admin"
MGT_SESSION_STORAGE="files"


ENV_MAGENTO_FOLDER_HOST="/tmp/var/www/magento"
ENV_MAGENTO_FOLDER_CONTAINER="/tmp/var/www/magento"
ENV_MAGENTO_SHARED_FOLDER_HOST="/mnt/efs.mounts/ecs_common/services/"$CI_PROJECT_NAME"/$DEPLOYMENT_ENV/"


cat <<EOF > .env
## AutoGenerated Docker-Compose .env File (based on Project and Environement)"

PROJECT_CODENAME=$PROJECT_CODENAME

AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID
AWS_ACTIVE_REGION=$AWS_ACTIVE_REGION

CODEBASE_DCKIMG_TAG=$CODEBASE_DCKIMG_TAG

MGT_DB_HOST=$MGT_DB_HOST
MGT_DB_NAME=$MGT_DB_NAME
MGT_DB_TBL_PRF=$MGT_DB_TBL_PRF

MGT_DB_ADMINNAME=$MGT_DB_ADMINNAME
MGT_DB_ADMINPASS=$MGT_DB_ADMINPASS

MGT_DB_TYPE=$MGT_DB_TYPE
MGT_DB_MODEL=$MGT_DB_MODEL
MGT_DB_PDO_TYPE=$MGT_DB_PDO_TYPE
MGT_DB_INIT_STM=$MGT_DB_INIT_STM

MGT_DATE=$MGT_DATE
MGT_CRKEY=$MGT_CRKEY
MGT_ADMIN_URL=$MGT_ADMIN_URL
MGT_SESSION_STORAGE=$MGT_SESSION_STORAGE


ENV_MAGENTO_FOLDER_HOST=$ENV_MAGENTO_FOLDER_HOST
ENV_MAGENTO_FOLDER_CONTAINER=$ENV_MAGENTO_FOLDER_CONTAINER
ENV_MAGENTO_SHARED_FOLDER_HOST=$ENV_MAGENTO_SHARED_FOLDER_HOST
EOF

cat .env
