
execute "echo hello world" do
  command "echo 'Hello #{node[:hello_world][:name]}!'"
end
