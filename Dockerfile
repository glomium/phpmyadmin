FROM alpine:3.11.2
MAINTAINER Sebastian Braun <sebastian.braun@fh-aachen.de>
# base alpine template

# Download requirements to serve php
RUN apk add --no-cache \
    apache2 \
    mysql-client \
    php7-apache2 \
    php7-ctype \
    php7-curl \
    php7-gd \
    php7-json \
    php7-mysqli \
    php7-mbstring \
    php7-openssl \
    php7-zip \
    rsync

# download phpmyadmin
RUN apk add --no-cache \
    phpmyadmin \
    php7-session \
 && rm /etc/apache2/conf.d/phpmyadmin.conf

# Copy configuration files
COPY config.inc.php /etc/phpmyadmin/config.inc.php

# Setup Webserver
COPY httpd.conf /etc/apache2/httpd.conf

EXPOSE 8080/tcp
ENTRYPOINT ["httpd", "-DFOREGROUND"]
