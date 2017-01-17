FROM  busybox
ARG PROJECT_CODENAME

COPY ${PROJECT_CODENAME} /var/www/${PROJECT_CODENAME}

ADD webapp.sh /
RUN chmod a+x /webapp.sh
CMD /webapp.sh

VOLUME /var/www/${PROJECT_CODENAME}
WORKDIR /var/www/${PROJECT_CODENAME}
