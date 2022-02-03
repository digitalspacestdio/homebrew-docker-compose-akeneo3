#!/bin/sh

sed -i 's/fastcgi_param  REMOTE_ADDR.*/fastcgi_param  REMOTE_ADDR        127.0.0.1;/g' /etc/nginx/fastcgi_params
