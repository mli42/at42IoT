#!/usr/bin/env bash

set -eo pipefail

VBOX_DEB="virtualbox-7.0_7.0.4-154605~Debian~bullseye_amd64.deb"
SERVER_IP="192.168.56.110"
LOCAL_BIN="${HOME}/.local/bin"

# Set oneself as sudoers
(su root -c "echo -e '$(whoami)\tALL=(ALL:ALL) ALL' >> /etc/sudoers")

sudo echo 'Installing Vagrant and VBox...'

# Install Vagrant
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant=2.3.4

# Install VBox
wget https://download.virtualbox.org/virtualbox/7.0.4/${VBOX_DEB}
sudo apt-get install -y ./${VBOX_DEB}
rm ./${VBOX_DEB}

# Install curl and prerequisite to test p2
sudo apt-get install -y curl

sudo bash -c "cat >> /etc/hosts <<-EOF
${SERVER_IP} app1.com
${SERVER_IP} app2.com
${SERVER_IP} otherapp.com
EOF
"

# Install prerequisites for p3

mkdir -p ${LOCAL_BIN}

## Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=v5.4.6 USE_SUDO="false" K3D_INSTALL_DIR="${LOCAL_BIN}" bash

## Install docker
curl -fsSL https://get.docker.com | VERSION=v20.10.22 bash
sudo usermod -aG docker $(whoami)

## Install kubectl
curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl
sudo install -o $(whoami) -g $(whoami) -m 0755 kubectl ${LOCAL_BIN}/kubectl
rm kubectl

echo "Please restart your shell"
