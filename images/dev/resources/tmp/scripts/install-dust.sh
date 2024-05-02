#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

archive="dust.tar.gz"

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

url=$(curl -s https://api.github.com/repos/bootandy/dust/releases/latest \
  | jq -r '.assets[] | .browser_download_url' \
  | grep "x86_64-unknown-linux-gnu.tar.gz")
curl -L -o $archive $url

tar xzf $archive --strip-components=1
rm $archive

ls -lah

install -o root -g root -m 0755 dust /usr/local/bin/dust

popd || exit 1
