#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

name="krew"
repo="kubernetes-sigs/$name"
artifact="$name-linux_amd64\.tar\.gz"
archive="$name.tar.gz"
install_dir="/usr/local/bin"

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

url=$(curl -s https://api.github.com/repos/$repo/releases/latest \
  | jq -r '.assets[] | .browser_download_url' \
  | grep --extended-regexp "$artifact")
curl -L -o $archive $url

tar xzf $archive
rm $archive

install -o root -g root -m 0755 $name-linux_amd64 $install_dir/kubectl-$name

popd || exit 1

sudo_user="${SUDO_USER:-$(logname 2>/dev/null || echo "$USER")}"
home_dir="$(getent passwd "$sudo_user" | cut -d: -f6)"
home_dir="${home_dir:-$HOME}"

sudo -u "$SUDO_USER" echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' > $home_dir/.oh-my-zsh/custom/krew.zsh
