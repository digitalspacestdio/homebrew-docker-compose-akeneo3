#!/bin/bash
set -e
#set -x

chown linuxbrew:linuxbrew /var/www 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var/session 2> /dev/null || true
chown linuxbrew:linuxbrew /home/linuxbrew/.composer 2> /dev/null || true
chown linuxbrew:linuxbrew /home/linuxbrew/.npm 2> /dev/null || true

cd /var/www

echo "[$(date +'%F %T')] ==> Staring fpm"
HOME=/home/linuxbrew su -p linuxbrew -c "exec /home/linuxbrew/.linuxbrew/sbin/php-fpm --nodaemonize --fpm-config /home/linuxbrew/.linuxbrew/etc/php/current/php-fpm.conf"
