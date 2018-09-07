package "php" do
  action :install
end

template "/var/www/html/info.php" do
    source "phpinfo.erb"
    mode "0644"
    notifies :restart, "service[httpd]"
end

