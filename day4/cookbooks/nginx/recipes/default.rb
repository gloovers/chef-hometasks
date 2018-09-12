#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

nginx_install "inst_nginx" do
  version node['nginx_version']
  jbossaddress lazy { search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first }
  land_value lazy { search(:nginx, "id:landing")[0]["name"] }
  nginx_port node['nginx_port']
  jboss_port node['jboss_port']
  jboss_deploy_app node['jboss_deploy_app']
end
