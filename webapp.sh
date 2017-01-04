#!/bin/sh

/bin/busybox sed -i 's/MAGDB_NAME/'"$DB_NAME"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/MAGDB_USER/'"$DB_USER"'/g' /var/www/magento/app/etc/local.xml
/bin/busybox sed -i 's/MAGDB_PASS/'"$DB_PASS"'/g' /var/www/magento/app/etc/local.xml

####################################################

/bin/busybox chown -R www-data:www-data /var/www/magento/var/session
/bin/busybox chown -R www-data:www-data /var/www/magento/media
/bin/busybox chown -R www-data:www-data /var/www/magento
/bin/busybox find /var/www/ -type d -exec chmod 755 {} \;
/bin/busybox find /var/www/ -type f -exec chmod 644 {} \;

####################################################



/bin/sh -c " while true; do echo '|'; sleep 60; done "
