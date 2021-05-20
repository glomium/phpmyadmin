# vim:set ft=dockerfile:
ARG BASEIMAGE=ubuntu:rolling
FROM $BASEIMAGE
MAINTAINER Sebastian Braun <sebastian.braun@fh-aachen.de>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install --no-install-recommends -y -q \
    apache2 \
    ca-certificates \
    phpmyadmin \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/

# Copy configuration files
COPY entrypoint.sh /entrypoint.sh
COPY phpmyadmin.conf /etc/dbconfig-common/phpmyadmin.conf

RUN rm /etc/apache2/sites-enabled/* \
 && ln -s /etc/phpmyadmin/apache.conf /etc/apache2/sites-enabled/phpmyadmin.conf \
 && chmod +x /entrypoint.sh \
 && dpkg-reconfigure phpmyadmin

EXPOSE 80/tcp
ENTRYPOINT ["/entrypoint.sh"]
