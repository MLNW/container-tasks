#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -b /usr/bin
