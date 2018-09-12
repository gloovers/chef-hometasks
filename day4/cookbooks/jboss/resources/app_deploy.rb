resource_name :app_deploy

property :version, String, default: '0.1.0'
property :app, String, required: true

default_action :deploy

load_current_value do
  version
end 


action :deploy do
  converge_if_changed :version do
    cookbook_file "/opt/jboss-eap-5.1/jboss-as/server/default/deploy/#{new_resource.file}" do
      source new_resource.file
    end
  end
end
