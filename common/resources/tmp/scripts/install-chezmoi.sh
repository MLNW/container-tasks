#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
