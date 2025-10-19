#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

name="kind"
repo="kubernetes-sigs/$name"
artifact="kind-linux-amd64"
install_dir="/usr/local/bin"

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

url=$(curl -s https://api.github.com/repos/$repo/releases/latest \
  | jq -r '.assets[] | .browser_download_url' \
  | grep --extended-regexp "$artifact")
curl -L -o $name $url

install -o root -g root -m 0755 $name $install_dir/$name

popd || exit 1
