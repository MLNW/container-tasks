#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  latest_version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  echo -e "Please provide the version to install, e.g., $0 $latest_version)"
  exit 1
fi

version=$1

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

curl -LO "https://dl.k8s.io/release/$version/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/release/$version/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

popd || exit 1
