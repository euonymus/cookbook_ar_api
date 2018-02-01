# settings for vhost
directory(node[:ar_api][:www_root])

# override apache config here
web_app(node[:ar_api][:app_name]) do
  server_name(node[:ar_api][:domain])
  docroot(node[:ar_api][:app_root])
  template('vhost.conf.erb')
end
