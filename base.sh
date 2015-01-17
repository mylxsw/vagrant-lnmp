#!/usr/bin/env bash

# 安装常用软件
sudo yum install vim -y
sudo yum install epel-release -y
sudo yum install zip -y


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

# MySQL依赖
sudo yum install cmake -y
sudo yum install gcc-c++ -y
sudo yum install bison -y
sudo yum install ncurses-devel -y
