include_middleware 'nginx'
include_middleware 'nginx/conf/rproxy'

service 'nginx' do
  action [:enable, :start]
end
