#!/usr/bin/env bash
# Bash scrip to set up web servers to deploy web_static

sudo apt-get update
sudo apt-get -y install nginx
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo echo "<html>
	<head>
    	</head>
    	<body>
		Holberton School
	</body>
	</html>"  /data/web_static/releases/test/index.html

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu /data/
chgrp -R ubuntu /data/
ln -sf /data/web_static/releases/test/ /data/web_static/current
http {
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;
    location /hbnb_static/ {
    alias /data/web_static/current/;
    index index.html index.htm;
    autoindex off;
    }

    location /redirect_me {
	return 301 http://cuberule.com/;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
    
    }
events {}
service nginx restart
