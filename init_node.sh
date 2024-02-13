#!/bin/bash
# node_init.sh
if [[ "$(whoami)" != "root" ]]; then
  echo "this script should be run as root!"
  exit 1
fi

echo "updating packages and repositories..."
sudo apt-get update
sudo apt-get upgrade

echo "installing nodejs and npm..."
sudo apt-get install nodejs npm

echo "installing nodejs version manager..."
sudo npm i -g n

echo "updating nodejs version to lts..."
sudo n lts
sudo hash -r

echo "updating npm version to latest..."
sudo npm i -g npm@latest

echo "installing typescript and bun..."
sudo npm i -g typescript bun

echo "initializing nodejs finished!"