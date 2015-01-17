#!/usr/bin/env bash


# -----------------------    安装mysql    ------------------------------
# 编译MySQL时间比较长，需要等很长时间

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

# MySQL 环境变量
cd ~
echo 'if [ -d "/usr/local/mysql/bin" ] ; then
    PATH=$PATH:/usr/local/mysql/bin
    export PATH
fi' > env_mysql.sh
sudo cp env_mysql.sh /etc/profile.d/env_mysql.sh