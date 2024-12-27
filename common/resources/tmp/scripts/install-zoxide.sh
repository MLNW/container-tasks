#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh \
  | bash -s -- --bin-dir /usr/bin
