#!/bin/bash

if [ -d "/etc/letsencrypt/live/${DOMAIN}" ]; then
	echo "OK"
  envsubst '${DOMAIN}' < ./nginx-rewrite.conf > /etc/nginx/sites-enabled/default
  service php8.2-fpm start 
	nginx -g 'daemon off;'
else
  echo "No certificate"
  exit 1
fi
