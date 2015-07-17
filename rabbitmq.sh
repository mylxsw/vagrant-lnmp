#!/usr/bin/env bash

if test -f /usr/local/vagrant.rabbitmq.lock
then
    exit
fi

sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo yum install rabbitmq-server -y
sudo yum install librabbitmq librabbitmq-devel -y

touch /usr/local/vagrant.rabbitmq.lock
