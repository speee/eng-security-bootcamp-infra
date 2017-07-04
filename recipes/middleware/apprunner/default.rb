group "apprunner" do
  gid 600
end

user "apprunner" do
  uid 600
  gid 600
  shell '/bin/bash'
  create_home true
end

directory '/home/apprunner/.ssh' do
  owner 'apprunner'
  group 'apprunner'
  mode '0700'
end

authorized_keys = attrs[:apprunner] && attrs[:apprunner][node[:host]] && attrs[:apprunner][node[:host]][:authorized_keys]
if authorized_keys && !authorized_keys.empty?
  authorized_keys.collect! { |key|
    next key if key =~ /\Assh-\w+\s/
    next nil unless (ui = node[:users][key])
    ui[:home] && ui[:home]['.ssh'] && ui[:home]['.ssh'][:authorized_keys]
  }.compact!

  file '/home/apprunner/.ssh/authorized_keys' do
    owner 'apprunner'
    group 'apprunner'
    mode '0600'
    content authorized_keys.join("\n")
  end
end
