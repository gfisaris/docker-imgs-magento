#!/bin/sh

cp -f /var/www/magento/app/etc/local.xml.template /var/www/magento/app/etc/local.xml

### Configure Magento Local.xml

sed -i 's/{{db_host}}/'"<![CDATA[$DB_HOST]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_name}}/'"<![CDATA[$DB_NAME]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_user}}/'"<![CDATA[$DB_ADMINNAME]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_pass}}/'"<![CDATA[$DB_ADMINPASS]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_prefix}}/'"<![CDATA[$DB_PREFIX]]>"'/g' /var/www/magento/app/etc/local.xml

sed -i 's/{{db_type}}/'"<![CDATA[$DB_TYPE]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_model}}/'"<![CDATA[$DB_MODEL]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_pdo_type}}/'"<![CDATA[$DB_PDO_TYPE]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{db_init_statemants}}/'"<![CDATA[$DB_INIT_STM]]>"'/g' /var/www/magento/app/etc/local.xml

sed -i 's/{{key}}/'"<![CDATA[$MGT_KEY]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{date}}/'"<![CDATA[$MGT_DATE]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{admin_frontname}}/'"<![CDATA[$MGT_ADMIN_URL]]>"'/g' /var/www/magento/app/etc/local.xml
sed -i 's/{{session_save}}/'"<![CDATA[$MGT_SESSION_STORAGE]]>"'/g' /var/www/magento/app/etc/local.xml

### Assign proper Files User ownership and permissions

chown -R www-data:www-data /var/www/magento/media
chown -R www-data:www-data /var/www/magento/var
chown -R www-data:www-data /var/www/magento
find /var/www/ -type d -exec chmod 755 {} \;
find /var/www/ -type f -exec chmod 644 {} \;

echo "<![CDATA[$DB_HOST]]>"
echo "<![CDATA[$DB_NAME]]>"
echo "<![CDATA[$DB_ADMINNAME]]>"
echo "<![CDATA[$DB_ADMINPASS]]>"
echo "<![CDATA[$DB_PREFIX]]>"
echo "<![CDATA[$DB_TYPE]]>"
echo "<![CDATA[$DB_MODEL]]>"
echo "<![CDATA[$DB_PDO_TYPE]]>"
echo "<![CDATA[$DB_INIT_STM]]>"
echo "<![CDATA[$MGT_KEY]]>"
echo "<![CDATA[$MGT_DATE]]>"
echo "<![CDATA[$MGT_ADMIN_URL]]>"
echo "<![CDATA[$MGT_SESSION_STORAGE]]>"

### Keep AppCode Container running..

/bin/sh -c " while true; do echo '|'; sleep 60; done "
