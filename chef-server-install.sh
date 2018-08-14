#!/usr/bin/env bash
set -e

echo "Install standalone chef server"

# -H for following external links
wget -H -q https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb

dpkg -i chef-server-core_12.17.33-1_amd64.deb

echo "################### start all services ###################"
chef-server-ctl reconfigure

echo "################### add admin user and group epam ###################"
chef-server-ctl user-create admin Admin Admin admin@admin.com 'PASSWORD' --filename ~/admin.pem
chef-server-ctl org-create epam 'Epam, Inc.' --association_user admin --filename ~/admin-validator.pem

echo "################### install chef-manage ###################"
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license

echo "################### install opscode-push-jobs-server ###################"
chef-server-ctl install opscode-push-jobs-server
chef-server-ctl reconfigure
opscode-push-jobs-server-ctl reconfigure

echo "################### install opscode-reporting ###################"
chef-server-ctl install opscode-reporting
chef-server-ctl reconfigure
opscode-reporting-ctl reconfigure --accept-license