#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

curl -fsSL https://d2lang.com/install.sh | sh -s --
