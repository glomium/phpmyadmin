# vim:set ft=dockerfile:
ARG BASEIMAGE=ubuntu:rolling
FROM $BASEIMAGE
MAINTAINER Sebastian Braun <sebastian.braun@fh-aachen.de>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install --no-install-recommends -y -q \
    ca-certificates \
    lighttpd \
    php-cgi \
    phpmyadmin \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/

# Copy configuration files
COPY phpmyadmin.conf /etc/dbconfig-common/phpmyadmin.conf

RUN dpkg-reconfigure phpmyadmin \
 && lighty-enable-mod fastcgi \
 && lighty-enable-mod fastcgi-php \
 && ln -s /etc/phpmyadmin/lighttpd.conf /etc/lighttpd/conf-enabled/phpmyadmin.conf

EXPOSE 80/tcp
ENTRYPOINT ["lighttpd" "-D"]
CMD ["-f", "/etc/lighttpd/lighttpd.conf"]
