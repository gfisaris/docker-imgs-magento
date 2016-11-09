FROM  busybox

RUN rm -rf /var/www
RUN mkdir -p /var/www/html

COPY magento /var/www/html

RUN rm -rf /var/www/html/var/log/* && \
    ln -sf /proc/self/fd/2 /var/www/html/var/log/system.log && \
    ln -sf /proc/self/fd/2 /var/www/html/var/log/exception.log && \
    /bin/busybox ls -all /var/www/html/var/log/

RUN /bin/busybox chown -R www-data:www-data /var/www/html && \
    /bin/busybox find /var/www/ -type d -exec chmod 755 {} \; && \
    /bin/busybox find /var/www/ -type f -exec chmod 644 {} \; && \
    /bin/busybox ls -all /var/www/html/ && \
    /bin/busybox ls -all /var/www/html/var/log/

VOLUME /var/www/html
WORKDIR /var/www/html

RUN ls -all /dev/

#CMD ["/bin/sh"]
ENTRYPOINT /bin/sh
