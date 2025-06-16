#!/bin/sh

# Substitute environment variables in nginx configuration template
envsubst '${API_KEY}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start nginx
exec nginx -g "daemon off;" 