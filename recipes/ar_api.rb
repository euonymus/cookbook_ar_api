pip_requirements "#{node[:ar_api][:app_root]}/requirements.txt"

# delete a uploads directory
directory node[:ar_api][:app_root] + "/static/uploads" do
  recursive true
  action :delete
end

# create a uploads directory
directory node[:ar_api][:app_root] + '/static/uploads' do
  owner "www-data"
  group "www-data"
  mode "0775"
  action :create
end
