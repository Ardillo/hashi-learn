#!/bin/bash

NOMAD_VERSION=0.9.6
NOMAD_ARCH=linux_amd64

echo "Getting nomad binary"
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_${NOMAD_ARCH}.zip -o nomad.zip
unzip nomad.zip
mv nomad /usr/local/bin/nomad

nomad -autocomplete-install

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

echo "Installing systemd unit files"
sysd_file=/opt/nomad/nomad.service
if [ -f ${sysd_file} ]; then
  cp ${sysd_file} /etc/systemd/system/
else
  echo "ERROR : ${sysd_file} not found"
fi

echo "Copy Nomad config file"
nomad_file=/opt/nomad/config.hcl
if [ -f ${nomad_file} ]; then
  cp ${nomad_file} /etc/nomad.d/
else
  echo "ERROR : ${nomad_file} not found"
fi

# start nomad service
systemctl start nomad
systemctl enable nomad

