#!/bin/bash
# This script installs the latest version of PlantUML. The version provided by
# package managers is often outdated, e.g., on Ubuntu it serves a version from
# 2020 (in 2024).

if [ "$(id -u)" -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

repo="plantuml/plantuml"
artifact="plantuml.jar"
install_dir="/opt/plantuml"
bin="/usr/local/bin/plantuml"

set -xe

mkdir -p $install_dir
curl -L -o $install_dir/$artifact \
  https://github.com/$repo/releases/latest/download/$artifact

cat <<EOF > $bin
#!/bin/bash
exec java -Djava.awt.headless=true -jar $install_dir/$artifact "\$@"
EOF
chmod +x $bin
