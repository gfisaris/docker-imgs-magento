FROM  busybox

RUN rm -rf /var/www
RUN mkdir -p /var/www/html

COPY magento /var/www/html


RUN /bin/busybox chown -R www-data:www-data /var/www/html
RUN /bin/busybox find /var/www/ -type d -exec chmod 755 {} \;
RUN /bin/busybox find /var/www/ -type f -exec chmod 644 {} \;

RUN /bin/busybox ls -all /var/www/html

VOLUME /var/www/html
WORKDIR /var/www/html
