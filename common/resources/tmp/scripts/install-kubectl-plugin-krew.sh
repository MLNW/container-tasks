#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

name="krew"
repo="kubernetes-sigs/$name"

set -xe

sudo ubi --project $repo \
  --rename-exe kubectl-$name \
  --in /usr/local/bin \
  --verbose

sudo_user="${SUDO_USER:-$(logname 2>/dev/null || echo "$USER")}"
home_dir="$(getent passwd "$sudo_user" | cut -d: -f6)"
home_dir="${home_dir:-$HOME}"

sudo -u "$SUDO_USER" echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' > $home_dir/.oh-my-zsh/custom/krew.zsh
