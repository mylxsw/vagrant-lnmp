#!/usr/bin/env bash

# --------------------------   安装NGINX  -----------------------------
cd ~
wget http://www.openssl.org/source/openssl-1.0.1j.tar.gz
tar -zxvf openssl-1.0.1j.tar.gz

wget http://nginx.org/download/nginx-1.6.2.tar.gz
tar -zxvf nginx-1.6.2.tar.gz
cd nginx-1.6.2

./configure --prefix=/usr/local/nginx --with-openssl=/root/openssl-1.0.1j --with-http_ssl_module
make
sudo make install

# Nginx 环境变量
cd ~
echo 'if [ -d "/usr/local/nginx/sbin" ] ; then
    PATH=$PATH:/usr/local/nginx/sbin
    export PATH
fi' > env_nginx.sh
sudo cp env_nginx.sh /etc/profile.d/env_nginx.sh

# 配置文件链接，方便编辑
sudo ln -s /usr/local/nginx/conf/nginx.conf /etc/nginx.conf

# Nginx配置
cd ~
echo 'user  vagrant;
worker_processes  auto;

error_log  logs/error.log;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       80;
        server_name  localhost;
        root         /vagrant/www;

        location / {
            index  index.html index.htm index.php;
        }

        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
	}
    }

    server {
        listen       443 ssl;
        server_name  localhost;
        root         /vagrant/www/security;

        ssl_certificate      /vagrant/server.crt;
        ssl_certificate_key  /vagrant/server_nopwd.key;

        ssl_session_cache    shared:SSL:1m;
        ssl_session_timeout  5m;

        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers  on;

        location / {
            index  index.html index.htm index.php;
            #try_files $uri /app_dev.php$is_args$args;
        }

        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
    }
}' > nginx.conf
sudo mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.default
sudo mv nginx.conf /usr/local/nginx/conf/nginx.conf
