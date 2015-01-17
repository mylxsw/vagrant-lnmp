#!/usr/bin/env bash

sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo yum install rabbitmq-server -y
sudo yum install librabbitmq librabbitmq-devel -y