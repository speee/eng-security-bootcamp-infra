remote_file '/etc/sudoers.d/sudo' do
  owner 'root'
  group 'root'
  mode '0644'
end

host = node[:host]
if attrs[:users][host]
  attrs[:users][host].each do |username|
    ui = node[:users][username]
    execute "usermod -a -G sudo #{ui[:name]}"
  end
end
