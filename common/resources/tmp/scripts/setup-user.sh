#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo -e "Please provide the user name to set up, e.g., $0 dev)"
  exit 1
fi

user_name=$1

useradd --shell /usr/bin/zsh -m $user_name
usermod --password $user_name $user_name
usermod -aG sudo $user_name
chpasswd <<< $user_name:$user_name
chsh -s /bin/zsh $user_name
