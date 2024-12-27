#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
