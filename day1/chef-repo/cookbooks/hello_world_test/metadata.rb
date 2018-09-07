name              'hello_world_test'
maintainer        'Jason Stenhouse'
maintainer_email  'jason.stenhouse@gmail.com'
license           'MIT'
description       'Hello World'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'

%w{ debian ubuntu centos suse fedora redhat }.each do |os|
  supports os
end

attribute 'hello_world/name',
  :display_name => 'Name for Hello World',
  :type => 'string',
  :required => 'required'