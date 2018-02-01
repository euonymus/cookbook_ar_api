default[:ar_api][:app_name]     = 'lampapp'

default[:ar_api][:www_root]     = "/var/www"
default[:ar_api][:app_root]     = "#{node[:ar_api][:www_root]}/#{node[:ar_api][:app_name]}"

default[:ar_api][:app_source]  = "/vagrant/src/#{node[:ar_api][:app_name]}"

default[:ar_api][:shell_base]  = '/usr/local/bin'

# The path to the data_bag_key on the remote server
default[:ar_api][:secretpath] = "/vagrant/src/secrets/data_bag_key"

# look for secret in file pointed to with ar_api attribute :secretpath
data_bag_secret = Chef::EncryptedDataBagItem.load_secret("#{node[:ar_api][:secretpath]}")

# Set domains from data_bag
domain_creds = Chef::EncryptedDataBagItem.load("envs", "domain", data_bag_secret)
if data_bag_secret && domain_envs = domain_creds[node.chef_environment]
  default[:ar_api][:domain] = domain_envs['domain']
end

# Set MySQL info from data_bag
mysqlinfo_creds = Chef::EncryptedDataBagItem.load("envs", "mysql", data_bag_secret)
if data_bag_secret && mysql_envs = mysqlinfo_creds[node.chef_environment]
  default[:ar_api][:db_name]      = mysql_envs['db_name']
  default[:ar_api][:db_user]      = mysql_envs['db_user']
end
# Set MySQL passwords from data_bag
mysql_creds = Chef::EncryptedDataBagItem.load("passwords", "mysql", data_bag_secret)
if data_bag_secret && mysql_passwords = mysql_creds[node.chef_environment]
  default[:ar_api][:db_password_root] = mysql_passwords['root']
  default[:ar_api][:db_password] = mysql_passwords['app']
end

