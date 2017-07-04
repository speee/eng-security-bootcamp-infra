execute 'chmod -x /etc/update-motd.d/10-help-text'
execute 'chmod -x /etc/update-motd.d/51-cloudguest'

template '/etc/update-motd.d/01-server-name' do
  owner 'root'
  group 'root'
  mode '0755'
  variables host: node[:host],
            roles: node[:roles],
            team_no: node[:team_no]
end
