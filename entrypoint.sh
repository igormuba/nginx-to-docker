#!/bin/bash

# Remove the default NGINX configuration
rm -f /etc/nginx/conf.d/default.conf

# Create a new NGINX configuration file
echo "" > /etc/nginx/conf.d/default.conf

# Loop through the environment variables for domains and containers
for pair in $(env | grep -oP 'TEST\d=.+' | sort); do
    pair="TEST${i}"
    domain_and_container="${!pair}"

    IFS='_' read -ra split <<< "$domain_and_container"
    domain="${split[0]}"
    container="${split[1]}"

    echo "server {" >> /etc/nginx/conf.d/default.conf
    echo "    listen 80;" >> /etc/nginx/conf.d/default.conf
    echo "    server_name $domain;" >> /etc/nginx/conf.d/default.conf
    echo "    location / {" >> /etc/nginx/conf.d/default.conf
    echo "        proxy_pass http://$container;" >> /etc/nginx/conf.d/default.conf
    echo "    }" >> /etc/nginx/conf.d/default.conf
    echo "}" >> /etc/nginx/conf.d/default.conf
    echo "" >> /etc/nginx/conf.d/default.conf
done

# Output NGINX configuration to console for debugging
cat /etc/nginx/conf.d/default.conf

# Start NGINX
nginx -g 'daemon off;'
