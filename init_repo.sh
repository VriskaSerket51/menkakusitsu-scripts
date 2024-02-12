#!/bin/bash
# init_repo.sh
if [ "$(whoami)" -ne "root" ]; then
  echo "this script should be run as root"
  exit 1
fi

if [ -z "$1" ]; then
  echo "first argument should be link of repository!"
  exit 1
fi

INIT_FILE=./init_node.sh
if [ ! -f "$INIT_FILE" ]; then
  echo "'$INIT_FILE' does not exists!"
  exit 1
fi

echo "initializing node packages..."
sudo bash $INIT_FILE

WORKSPACE_DIR=~/vs_workspace
if [ ! -d "$WORKSPACE_DIR" ]; then
  mkdir $WORKSPACE_DIR
fi
cd $WORKSPACE_DIR

REPO_URL=$O
REPO_NAME=$(echo ${REPO_URL##*/})

echo "downloading repository..."
git clone $REPO_URL $REPO_NAME
cd $REPO_NAME

echo "installing dependencies..."
npm i

echo "initializing repository finished!"