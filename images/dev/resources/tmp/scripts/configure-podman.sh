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

config='unqualified-search-registries = ["docker.io"]'
sed -i /etc/containers/registries.conf \
  -e "/# unqualified-search-registries/a $config"

cp \
  /usr/share/containers/containers.conf \
  /usr/share/containers/storage.conf \
  /etc/containers/

# See: https://www.redhat.com/sysadmin/podman-inside-container

echo $user_name:10000:10000 > /etc/subuid
echo $user_name:10000:10000 > /etc/subgid

sed -i /etc/containers/storage.conf \
  -e 's|^#mount_program|mount_program|g' \
  -e '/additionalimage.*/a "/var/lib/shared",' \
  -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g'

mkdir -p \
  /var/lib/shared/overlay-images \
  /var/lib/shared/overlay-layers \
  /var/lib/shared/vfs-images \
  /var/lib/shared/vfs-layers
touch /var/lib/shared/overlay-images/images.lock
touch /var/lib/shared/overlay-layers/layers.lock
touch /var/lib/shared/vfs-images/images.lock
touch /var/lib/shared/vfs-layers/layers.lock
