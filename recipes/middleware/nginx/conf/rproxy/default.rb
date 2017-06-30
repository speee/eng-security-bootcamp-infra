template '/etc/nginx/conf.d/app.conf' do
  notifies :restart, 'service[nginx]'
end
