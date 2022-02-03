#!/bin/bash
set -e
#set -x

HOST_MACHINE_IP=$(getent hosts host.docker.internal | awk '{print $1}' || echo '172.17.0.1')
HOST_MACHINE_IP=${HOST_MACHINE_IP:-'172.17.0.1'}
cd $(readlink /home/linuxbrew/.linuxbrew/etc/php/current)
sed 's/xdebug.client_host=.*/xdebug.client_host='$HOST_MACHINE_IP'/g' php.ini.dist > php.ini
cd -

chown linuxbrew:linuxbrew /var/www 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var/session 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var/session/* 2> /dev/null || true
chown linuxbrew:linuxbrew /home/linuxbrew/.composer 2> /dev/null || true
chown linuxbrew:linuxbrew /home/linuxbrew/.npm 2> /dev/null || true

cd /var/www

echo "[$(date +'%F %T')] ==> Staring fpm"
HOME=/home/linuxbrew su -p linuxbrew -c "exec /home/linuxbrew/.linuxbrew/sbin/php-fpm --nodaemonize --fpm-config /home/linuxbrew/.linuxbrew/etc/php/current/php-fpm.conf"
