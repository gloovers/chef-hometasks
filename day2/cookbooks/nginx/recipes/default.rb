#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

service 'nginx' do
  supports :restart => true
  action [ :enable, :start ]
end 

template '/etc/nginx/conf.d/jboss.conf' do
  source 'jboss.conf.erb'
  variables(
    jbossaddress: search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    jboss_port: node['jboss_port'],
    jboss_deploy_app: node['jboss_deploy_app'],
    nginx_port: node['nginx_port'])
  notifies :restart, 'service[nginx]'
end

template '/usr/share/nginx/html/land.html' do
  source 'land.html.erb'
  variables(
    name: search(:nginx, "id:landing")[0]["name"]
           )
  sensitive true
  notifies :restart, 'service[nginx]'
end

