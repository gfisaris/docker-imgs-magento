FROM  busybox

#RUN addgroup www-data
#RUN adduser -HD -G www-data www-data

RUN rm -rf /var/www
RUN mkdir -p /var/www/

COPY build/magento /tmp/magento
COPY build/magento-sample-data /tmp/magento-sample-data

RUN /bin/busybox cp -rf /tmp/magento /var/www/
RUN /bin/busybox cp -rf /tmp/magento-sample-data/* /var/www/magento/

RUN /bin/busybox chown -R www-data:www-data /var/www/magento
RUN /bin/busybox find /var/www/ -type d -exec chmod 700 {} \;
RUN /bin/busybox find /var/www/ -type f -exec chmod 600 {} \;

RUN /bin/busybox ls -all /var/www/magento



