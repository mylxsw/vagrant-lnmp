#!/usr/bin/env bash


# 安装常用软件
sudo yum install vim -y

# 安装相关的依赖
sudo yum install gcc -y
sudo yum install libxml2-devel -y
sudo yum install openssl-devel -y
sudo yum install libcurl-devel -y
sudo yum install libjpeg libjpeg-devel -y
sudo yum install libpng libpng-devel -y
sudo yum install freetype freetype-devel -y
sudo yum install pcre-devel -y

cd ~
wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz
tar -zxvf libmcrypt-2.5.7.tar.gz
cd libmcrypt-2.5.7
./configure
make
sudo make install

# 修正php启用opcache失败问题
sudo sh -c 'echo /usr/local/lib > /etc/ld.so.conf.d/local.conf'
sudo ldconfig -v

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

# ------------------------    安装PHP5.6    ---------------------------
# 下载PHP源码并执行编译安装
cd ~
wget http://cn2.php.net/distributions/php-5.6.4.tar.gz
tar -zxvf php-5.6.4.tar.gz 

cd php-5.6.4

./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-fpm --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-gettext --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-opcache

make
sudo make install
sudo cp php.ini-development  /usr/local/php/etc/php.ini
sudo mv /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf



# -----------------------    安装mysql    ------------------------------
# 编译MySQL时间比较长，需要等很长时间
sudo yum install cmake -y
sudo yum install gcc-c++ -y
sudo yum install bison -y
sudo yum install ncurses-devel -y

cd ~
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.21.tar.gz
tar -zxvf mysql-5.6.21.tar.gz
cd mysql-5.6.21

cmake .
make
sudo make install


sudo groupadd mysql
sudo useradd -r -g mysql mysql

cd /usr/local/mysql/
sudo chown -R root .
sudo chown -R mysql data


sudo yum install perl-Data-Dumper -y

sudo scripts/mysql_install_db --user=mysql
sudo cp support-files/my-default.cnf /etc/my.cnf

sudo cp support-files/mysql.server /etc/init.d/mysql
sudo chmod u+x /etc/init.d/mysql
sudo chkconfig --add mysql

