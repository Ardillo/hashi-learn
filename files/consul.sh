#!/bin/bash

CONSUL_VERSION=1.6.1
CONSUL_ARCH=linux_amd64

echo "Getting Consul binary"
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_${CONSUL_ARCH}.zip -o consul.zip
unzip -o consul.zip
mv consul /usr/local/bin/consul

consul -autocomplete-install

mkdir -p /etc/consul.d

echo "Installing systemd unit files"
sysd_file=/opt/consul/consul.service
if [ -f ${sysd_file} ]; then
  cp ${sysd_file} /etc/systemd/system/
else
  echo "ERROR : ${sysd_file} not found"
fi

# start consul service
systemctl start consul
systemctl enable consul
