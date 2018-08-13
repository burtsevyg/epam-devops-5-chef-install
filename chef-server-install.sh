#!/usr/bin/env bash
set -e

echo "Install standalone chef server"

# -H for following external links
wget -H -q https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb

sudo dpkg -i chef-server-core_12.17.33-1_amd64.deb

echo "################### start all services ###################"
sudo chef-server-ctl reconfigure

echo "################### add admin user and group epam ###################"
sudo chef-server-ctl user-create admin Admin Admin admin@admin.com 'PASSWORD' --filename ~/admin.pem
sudo chef-server-ctl org-create epam 'Epam, Inc.' --association_user admin --filename ~/admin-validator.pem

echo "################### install chef-manage ###################"
sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure
sudo chef-server-ctl reconfigure

echo "################### install opscode-push-jobs-server ###################"
sudo chef-server-ctl install opscode-push-jobs-server
sudo chef-server-ctl reconfigure
sudo opscode-push-jobs-server-ctl reconfigure