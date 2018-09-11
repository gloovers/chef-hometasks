#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package "java-1.7.0-openjdk" do
  action :install
end

cookbook_file '/opt/jdk-6u45-linux-amd64.rpm' do
 source 'jdk-6u45-linux-amd64.rpm'
 action :create
end

rpm_package '/opt/jdk-6u45-linux-amd64.rpm' do
 action :install
end

package "unzip" do
  action :install
end

cookbook_file '/tmp/jboss-eap-5.1.2.zip' do
  source 'jboss-eap-5.1.2.zip'
  action :create
end

execute 'unzip' do
  command 'unzip /tmp/jboss-eap-5.1.2.zip -d /opt/'
  action :run
end

cookbook_file '/etc/systemd/system/jboss.service' do
  source 'jboss.service'
  action :create
end

service 'jboss' do
  action [ :enable, :start ]
end

cookbook_file '/opt/jboss-eap-5.1/jboss-as/server/default/deploy/sample.war' do
  source 'sample.war'
  action :create
end

