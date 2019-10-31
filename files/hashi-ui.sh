#!/bin/bash

HASHI_UI_VERSION=1.1.2
HASHI_UI_ARCH=linux-amd64

echo "Getting Hashi-UI binary"
curl -sSL https://github.com/jippi/hashi-ui/releases/download/v${HASHI_UI_VERSION}/hashi-ui-${HASHI_UI_ARCH} -o /usr/local/bin/hashi-ui
chmod +x /usr/local/bin/hashi-ui

echo "Running Hashi-UI to enable nomad and consul"
#hashi-ui --nomad-enable --consul-enable 
#echo "Installing systemd unit files"
sysd_file=/opt/hashi-ui/hashiui.service
if [ -f ${sysd_file} ]; then
  cp ${sysd_file} /etc/systemd/system/
else
  echo "ERROR : ${sysd_file} not found"
fi

# start Hashi-UI service
systemctl start hashiui
systemctl enable hashiui
