#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo -e "Please provide the version to install, e.g., $0 1.7.1)"
  exit 1
fi

version=$1

set -xe

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

pushd "$temp_dir" || exit 1

curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v$version/clusterctl-linux-amd64 -o clusterctl

install -o root -g root -m 0755 clusterctl /usr/local/bin/clusterctl

popd || exit 1
