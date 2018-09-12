resource_name :nginx_install

property :version, String, default: '1.12.0'
property :nginx_port, String, default: '80'
property :jboss_port, String, default: '8080'
property :land_value, String, default: 'Dev'
property :source, String, default: lazy { |v| "https://nginx.org/packages/centos/7/x86_64/RPMS/nginx-#{v.version}-1.el7_4.ngx.x86_64.rpm" }
property :jbossaddress, String, required: true
property :jboss_deploy_app, String, required: true

default_action :install

action :install do
  remote_file "/tmp/nginx-#{new_resource.version}-1.el7.ngx.x86_64.rpm" do
    source "#{new_resource.source}"
  end

  rpm_package "/tmp/nginx-#{new_resource.version}-1.el7.ngx.x86_64.rpm" do
    action :install
  end

  service 'nginx' do
    action [:enable, :start]
  end

  template '/etc/nginx/conf.d/jboss.conf' do
    source 'jboss.conf.erb'
    variables(
      jbossaddress: new_resource.jbossaddress ,
      jboss_port: new_resource.jboss_port,
      jboss_deploy_app: new_resource.jboss_deploy_app,
      nginx_port: new_resource.nginx_port
             ) 
    notifies :restart, 'service[nginx]'
  end

  template '/usr/share/nginx/html/land.html' do
    source 'land.html.erb'
    variables(
      name: new_resource.land_value
           )
    sensitive true
    notifies :restart, 'service[nginx]'
  end

end
