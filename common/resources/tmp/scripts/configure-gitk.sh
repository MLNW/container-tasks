#!/bin/bash

folder=~/.config/git
file=$folder/gitk

set -xe

mkdir -p $folder

curl -L \
  -o $file \
  https://raw.githubusercontent.com/dracula/gitk/master/gitk

cat <<EOF >> $file

set mainfont {{MesloLGS NF} 10}
set textfont {{MesloLGS NF} 10}
set uifont {{MesloLGS NF} 9}
EOF
