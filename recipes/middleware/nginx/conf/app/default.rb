directory '/etc/nginx/conf.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

remote_file '/etc/nginx/conf.d/rails.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

directory '/etc/nginx/sites-available' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/nginx/sites-available/default' do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]'
  variables server_name: "#{node[:host]}.speee-sbc.mrkn.jp"
end
