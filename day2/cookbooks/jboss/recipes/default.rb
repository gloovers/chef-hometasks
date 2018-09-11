#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/home/vagrant/jdk-6u45-linux-amd64.rpm' do
  source 'jdk-6u45-linux-amd64.rpm'
  action :create
end

rpm_package '/home/vagrant/jdk-6u45-linux-amd64.rpm' do
  action :install
end

package 'unzip' do
  action :install
end

cookbook_file '/home/vagrant/jboss-eap-5.1.2.zip' do
  source 'jboss-eap-5.1.2.zip'
  action :create
end

execute 'unzip' do
  command 'unzip -o /home/vagrant/jboss-eap-5.1.2.zip -d /opt/'
  action :run
end



template '/etc/systemd/system/jboss.service' do
  source 'jboss.service.erb'
  variables(
    ipaddress_node: node["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first
           )
end

systemd_unit 'jboss' do
  action [ :reload, :enable, :start ]
end

=begin
service 'jboss' do
  action [ :enable, :start ]
end
=end
cookbook_file '/opt/jboss-eap-5.1/jboss-as/server/default/deploy/sample.war' do
  source 'sample.war'
  action :create
end

