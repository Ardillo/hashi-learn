#!/bin/bash

CONSUL_VERSION=1.6.1
CONSUL_ARCH=linux_amd64

echo "Getting Consul binary"

wget -q https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_${CONSUL_ARCH}.zip -O /tmp/consul_${CONSUL_VERSION}_${CONSUL_ARCH}.zip
cd /tmp
unzip -o /tmp/consul_${CONSUL_VERSION}_${CONSUL_ARCH}.zip
mv consul /usr/local/bin/consul

mkdir -p /var/log/consul
mkdir -p /etc/consul
mkdir -p /var/consul

