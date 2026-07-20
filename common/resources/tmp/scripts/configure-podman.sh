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

set -xe

config='unqualified-search-registries = ["docker.io"]'
sed -i /etc/containers/registries.conf \
  -e "/# unqualified-search-registries/a $config"

cp \
  /usr/share/containers/containers.conf \
  /usr/share/containers/storage.conf \
  /etc/containers/

# See: https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md#etcsubuid-and-etcsubgid-configuration
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $user_name

# See: https://www.redhat.com/sysadmin/podman-inside-container
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

# Container registries running locally are allowed to be used insecurely
# This is useful, e.g., when running a microk8s cluster with the registry
# enabled.
cat <<EOF >> /etc/containers/registries.conf

[[registry]]
location = "localhost"
insecure = true
EOF

mkdir -p /etc/containers/containers.conf.d

# Ensure Podman socket is always running
cat > /etc/containers/containers.conf.d/timeout.conf <<'EOF'
[engine]
service_timeout=0
EOF
# Use Netavark as the network backend
cat > /etc/containers/containers.conf.d/network.conf <<'EOF'
[network]
network_backend="netavark"
EOF

# Rootful Podman socket
ln -sf /usr/bin/podman /usr/bin/docker

# Enable linger via file so it works without a running systemd (e.g., during
# container build / version testing). loginctl enable-linger would require
# booted systemd and breaks WSL startup if called on every login.
mkdir -p /var/lib/systemd/linger
touch /var/lib/systemd/linger/$user_name

# Pre-enable podman user socket via symlink (equivalent to `systemctl --user
# enable podman.socket` but works without a running systemd at build time).
user_home=$(getent passwd $user_name | cut -d: -f6)
mkdir -p $user_home/.config/systemd/user/default.target.wants
ln -sf /usr/lib/systemd/user/podman.socket \
  $user_home/.config/systemd/user/default.target.wants/podman.socket
chown -R $user_name:$user_name $user_home/.config

# Only wire up the Docker socket shim when systemd is actually running.
cat <<'EOF' > /etc/profile.d/podman-socket.sh
if [ -d /run/systemd/private ]; then
  sudo ln -sf "/run/user/$(id -u)/podman/podman.sock" /var/run/docker.sock 2>/dev/null || true
fi
EOF
