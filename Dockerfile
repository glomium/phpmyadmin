# vim:set ft=dockerfile:
ARG BASEIMAGE=ubuntu:rolling
FROM $BASEIMAGE
MAINTAINER Sebastian Braun <sebastian.braun@fh-aachen.de>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

# install lighttpd with php
RUN apt-get update && apt-get install --no-install-recommends -y -q \
    ca-certificates \
    default-mysql-client \
    lighttpd \
    php-cgi \
    php-fpm \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN lighty-enable-mod fastcgi \
 && lighty-enable-mod fastcgi-php \
 && sed -i 's|server.errorlog  |# server.errorlog|' /etc/lighttpd/lighttpd.conf

ENTRYPOINT ["lighttpd", "-D"]

RUN apt-get update && apt-get install --no-install-recommends -y -q \
    phpmyadmin \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY phpmyadmin.conf /etc/dbconfig-common/phpmyadmin.conf

RUN dpkg-reconfigure phpmyadmin \
 && ln -s /etc/phpmyadmin/lighttpd.conf /etc/lighttpd/conf-enabled/phpmyadmin.conf

EXPOSE 80/tcp
CMD ["-f", "/etc/lighttpd/lighttpd.conf"]
