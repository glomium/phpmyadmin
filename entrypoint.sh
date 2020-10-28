#!/bin/sh
set -e

. /etc/apache2/envvars
mkdir -p /var/run/apache2

if [ -z $@ ]; then
    apache2 -DFOREGROUND
else
    exec "$@"
fi
