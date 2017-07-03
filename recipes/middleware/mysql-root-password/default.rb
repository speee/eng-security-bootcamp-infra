service 'mysql' do
  action :stop
  not_if 'test -f /etc/mysql/root-password-initialized'
end

remote_file '/root/mysql-root-password.sh' do
  owner 'root'
  group 'root'
  mode '0600'
  not_if 'test -f /etc/mysql/root-password-initialized'
end

remote_file '/root/mysql-root-password.sql' do
  owner 'root'
  group 'root'
  mode '0600'
  not_if 'test -f /etc/mysql/root-password-initialized'
end

execute '/bin/bash -x /root/mysql-root-password.sh && touch /etc/mysql/root-password-initialized' do
  not_if 'test -f /etc/mysql/root-password-initialized'
end

execute 'rm -f /root/mysql-root-password.sql'
