#!/bin/bash

VAULT_VERSION=1.2.3
VAULT_ARCH=linux_amd64

echo "Getting vault binary"
curl -sSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_${VAULT_ARCH}.zip -o vault.zip
unzip vault.zip
mv vault /usr/local/bin/vault

vault -autocomplete-install

sudo mkdir -p /etc/vault.d

echo "Installing systemd unit files"
sysd_file=/opt/vault/vault.service
if [ -f ${sysd_file} ]; then
  cp ${sysd_file} /etc/systemd/system/
else
  echo "ERROR : ${sysd_file} not found"
fi

#start vault service
systemctl start vault
systemctl enable vault

echo "export VAULT_ADDR='http://127.0.0.1:8200'" >> /etc/bash.bashrc
