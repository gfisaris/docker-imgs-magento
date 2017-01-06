#!/bin/sh

/bin/busybox cp -f /var/www/magento/app/etc/local.xml.template /var/www/magento/app/etc/local.xml

/bin/busybox sed -i 's/{{date}}/'"$DB_NAME"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{key}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_prefix}}/'"$DB_PASS"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_host}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_user}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_pass}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_name}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_init_statemants}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_model}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_type}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{db_pdo_type}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{session_save}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/{{admin_frontname}}/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml

####################################################

/bin/busybox chown -R www-data:www-data /var/www/magento/media
/bin/busybox chown -R www-data:www-data /var/www/magento/var
/bin/busybox chown -R www-data:www-data /var/www/magento
/bin/busybox find /var/www/ -type d -exec chmod 755 {} \;
/bin/busybox find /var/www/ -type f -exec chmod 644 {} \;

####################################################

/bin/sh -c " while true; do echo '|'; sleep 60; done "
