#!/bin/sh

cp -f /var/www/${PROJECT_CODENAME}/app/etc/local.xml.template /var/www/${PROJECT_CODENAME}/app/etc/local.xml

### Configure Magento Local.xml

sed -i 's/{{db_host}}/'"<![CDATA[$MAGENTO_DB_HOST]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{db_name}}/'"<![CDATA[$MAGENTO_DB_NAME]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{db_prefix}}/'"<![CDATA[$MAGENTO_DB_TABLE_PREFIX]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml

sed -i 's/{{db_user}}/'"<![CDATA[$MAGENTO_DB_ADMINNAME]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{db_pass}}/'"<![CDATA[$MAGENTO_DB_ADMINPASS]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml

sed -i 's/{{db_type}}/'"<![CDATA[$MAGENTO_DB_TYPE]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{db_model}}/'"<![CDATA[$MAGENTO_DB_MODEL]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{db_pdo_type}}/'"<![CDATA[$MAGENTO_DB_PDO_TYPE]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{db_init_statemants}}/'"<![CDATA[$MAGENTO_DB_INIT_STATEMENTS]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml

sed -i 's/{{key}}/'"<![CDATA[$MAGENTO_ENCRYPTION_KEY]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{date}}/'"<![CDATA[$MAGENTO_INSTALL_DATE]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{session_save}}/'"<![CDATA[$MAGENTO_SESSION_STORAGE]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml
sed -i 's/{{admin_frontname}}/'"<![CDATA[$MAGENTO_ADMINPANEL_URL]]>"'/g' /var/www/${PROJECT_CODENAME}/app/etc/local.xml

### Assign proper Files User ownership and permissions

chown -R www-data:www-data /var/www/${PROJECT_CODENAME}/media
chown -R www-data:www-data /var/www/${PROJECT_CODENAME}/var
chown -R www-data:www-data /var/www/${PROJECT_CODENAME}
find /var/www/ -type d -exec chmod 755 {} \;
find /var/www/ -type f -exec chmod 644 {} \;

### Keep AppCode Container running..

/bin/sh -c " while true; do echo '|'; sleep 60; done "
