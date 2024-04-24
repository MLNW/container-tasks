#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

archive="scc.tar.gz"

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

url=$(curl -s https://api.github.com/repos/boyter/scc/releases/latest \
  | jq -r '.assets[] | .browser_download_url' \
  | grep "Linux_x86_64")
curl -L -o $archive $url

tar xzf $archive

install -o root -g root -m 0755 scc /usr/local/bin/scc

popd || exit 1
