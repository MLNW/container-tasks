#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

set -xe

curl -L -o /usr/bin/yq \
  https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64

chmod +x /usr/bin/yq
