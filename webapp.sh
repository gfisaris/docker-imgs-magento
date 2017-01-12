#!/bin/sh

cp -f /var/www/magento/app/etc/local.xml.template /var/www/magento/app/etc/local.xml

### Configure Magento Local.xml

sed -i 's/{{db_host}}/'"$DB_HOST"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_name}}/'"$DB_NAME"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_user}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_pass}}/'"$DB_PASS"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_prefix}}/'"$DB_PREFIX"'/g' /var/www/magento/app/etc/local.xml

sed -i 's/{{db_type}}/'"$DB_TYPE"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_model}}/'"$DB_MODEL"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_pdo_type}}/'"$DB_PDO_TYPE"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_init_statemants}}/'"$DB_INIT_STM"'/g' /var/www/magento/app/etc/local.xml

sed -i 's/{{key}}/'"$MGT_KEY"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{date}}/'"$MGT_DATE"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{admin_frontname}}/'"$MGT_ADMIN_URL"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{session_save}}/'"$MGT_SESSION_STORAGE"'/g' /var/www/magento/app/etc/local.xml

### Assign proper Files User ownership and permissions

chown -R www-data:www-data /var/www/magento/media
chown -R www-data:www-data /var/www/magento/var
chown -R www-data:www-data /var/www/magento
find /var/www/ -type d -exec chmod 755 {} \;
find /var/www/ -type f -exec chmod 644 {} \;

### Keep AppCode Container running..

/bin/sh -c " while true; do echo '|'; sleep 60; done "
