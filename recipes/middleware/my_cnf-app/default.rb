directory '/etc/mysql' do
  owner 'root'
  group 'root'
  mode '0755'
end

remote_file '/etc/mysql/my.cnf' do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[mysql]'
end
