#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo -e "Please provide the version to install, e.g., $0 v4.2.3"
  exit 1
fi

version=$1
archive="helm-$version-linux-amd64.tar.gz"

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

curl -LO "https://get.helm.sh/$archive"
curl -LO "https://get.helm.sh/$archive.sha256sum"
sha256sum --check "$archive.sha256sum"

tar -xzf "$archive" --strip-components=1 linux-amd64/helm

install -o root -g root -m 0755 helm /usr/local/bin/helm

popd || exit 1
