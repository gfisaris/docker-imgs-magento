FROM  busybox

RUN rm -rf /var/www
RUN mkdir -p /var/www/magento
COPY magento /var/www/magento

ADD webapp.sh /
RUN chmod a+x /webapp.sh
CMD /webapp.sh

VOLUME /var/www/magento
WORKDIR /var/www/magento
