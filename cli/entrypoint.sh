#!/bin/bash
set -e
#set -x

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
