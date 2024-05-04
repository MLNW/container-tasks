#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

name="dust"
archive="$name.tar.gz"
repo="bootandy/dust"
artifact="x86_64-unknown-linux-gnu.tar.gz"

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

url=$(curl -s https://api.github.com/repos/$repo/releases/latest \
  | jq -r '.assets[] | .browser_download_url' \
  | grep -e "$artifact")
curl -L -o $archive $url

tar xzf $archive --strip-components=1
rm $archive

install -o root -g root -m 0755 $name /usr/local/bin/$name

popd || exit 1
