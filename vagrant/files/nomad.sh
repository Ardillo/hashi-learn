#!/bin/bash

NOMAD_VERSION=0.9.6
NOMAD_ARCH=linux_amd64

echo "Getting nomad binary"
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_${NOMAD_ARCH}.zip -o nomad.zip
unzip nomad.zip
mv nomad /usr/local/bin/nomad

mkdir -p /etc/nomad.d
