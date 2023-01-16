#!/usr/bin/env bash

set -eo pipefail

VBOX_DEB="virtualbox-7.0_7.0.4-154605~Debian~bullseye_amd64.deb"
SERVER_IP="192.168.56.110"

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
