#!/bin/bash

echo "Executing base script"
apt-get update

echo "installing unzip"
apt-get install -y unzip

echo "installing tmux"
apt-get install -y tmux

echo "installing curl"
apt-get install -y curl

echo "installing vim"
apt-get install -y vim


