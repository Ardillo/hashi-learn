#!/bin/bash

CONSUL_VERSION=1.6.1
CONSUL_ARCH=linux_amd64

echo "Getting Consul binary"
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_${CONSUL_ARCH}.zip -o consul.zip
unzip -o consul.zip
mv consul /usr/local/bin/consul

mkdir -p /etc/consul.d

echo "Installing systemd unit files"
svc_file=/opt/consul/consul.service
if [ -f ${svc_file} ]; then
  cp ${svc_file} /etc/systemd/system/
fi
