#!/usr/bin/env bash

set -e

echo "Install chef dk"

# -H for following external links
wget -H -q https://packages.chef.io/files/stable/chefdk/3.1.0/ubuntu/16.04/chefdk_3.1.0-1_amd64.deb

sudo dpkg -i chefdk_3.1.0-1_amd64.deb

echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

echo "export PATH=$(which ruby):\$PATH" >> ~/.bash_profile && source ~/.bash_profile

chef generate app chef-repo

mkdir -p ~/chef-repo/.chef

echo '.chef' >> ~/chef-repo/.gitignore

scp root@server:/root/admin.pem ~/chef-repo/.chef
scp root@server:/root/admin-validator.pem ~/chef-repo/.chef

