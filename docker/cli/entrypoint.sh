#!/bin/bash
set -e
#set -x

HOST_MACHINE_IP=$(getent hosts host.docker.internal | awk '{print $1}' || echo '172.17.0.1')
HOST_MACHINE_IP=${HOST_MACHINE_IP:-'172.17.0.1'}
cd $(readlink /home/linuxbrew/.linuxbrew/etc/php/current)
sed 's/xdebug.client_host=.*/xdebug.client_host='$HOST_MACHINE_IP'/g' php.ini.dist > php.ini
cd - > /dev/null

chown linuxbrew:linuxbrew /var/www 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var/session 2> /dev/null || true
chown linuxbrew:linuxbrew /var/www/var/session/* 2> /dev/null || true
chown linuxbrew:linuxbrew /home/linuxbrew/.composer 2> /dev/null || true
chown linuxbrew:linuxbrew /home/linuxbrew/.npm 2> /dev/null || true

cd /var/www

for i in "$@"; do
    i="${i//\\/\\\\}"
    i="${i//$/\\$}"
    C="$C \"${i//\"/\\\"}\""
done

HOME=/home/linuxbrew su -p linuxbrew -- -c "exec $C"
