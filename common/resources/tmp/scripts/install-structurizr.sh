#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

repo="structurizr/cli"
artifact="structurizr-cli.zip"
install_dir="/opt/structurizr"

set -xe

mkdir -p $install_dir
pushd "$install_dir" || exit 1
curl -L -o $artifact \
  https://github.com/$repo/releases/latest/download/$artifact
unzip $artifact
rm $artifact
popd || exit 1

ln -s $install_dir/structurizr.sh /usr/local/bin/structurizr
