#!/bin/sh
#
# Entrypoint Script for the container

/usr/bin/umask 0002
/usr/sbin/php-fpm -D
/usr/sbin/httpd -D FOREGROUND -k start
