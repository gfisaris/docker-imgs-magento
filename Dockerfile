FROM  busybox

RUN rm -rf /var/www
RUN mkdir -p /var/www/magento
COPY magento /var/www/magento

#RUN rm -rf /var/www/magento/app/etc/local.xml
#COPY magento.local.xml /var/www/magento/app/etc/local.xml

#RUN /bin/busybox chown -R www-data:www-data /var/www/magento && \
#    /bin/busybox find /var/www/ -type d -exec chmod 755 {} \; && \
#    /bin/busybox find /var/www/ -type f -exec chmod 644 {} \; && \
#    echo "Applied User Owner and Permissions Configuration on Magento Folder"
#
#RUN /bin/busybox chown -R www-data:www-data /var/www/magento/media && \
#    /bin/busybox chown -R www-data:www-data /var/www/magento/var/session

ADD webapp.sh /
RUN chmod a+x /webapp.sh
CMD /webapp.sh

VOLUME /var/www/magento
WORKDIR /var/www/magento
