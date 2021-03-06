# Preparation

host = node[:host]
if node[:team_no] > 0
  attrs[:users][host].concat(attrs[:users]['app-000'])
  attrs[:apprunner][host][:authorized_keys].concat(attrs[:apprunner]['app-000'][:authorized_keys])
end

# Packages

include_middleware 'base'
include_middleware 'users'
include_middleware 'sudoers-app'
include_middleware 'apprunner'
include_middleware 'nodejs'
include_middleware 'php-fpm'
include_middleware 'ruby24'
include_middleware 'rubygems'
include_middleware 'bundler'
include_middleware 'build-essential'
include_middleware 'sqlite3'
include_middleware 'imagemagick'
include_middleware 'libxml2-dev'
include_middleware 'libxslt1-dev'
include_middleware 'libmysqlclient-dev'
include_middleware 'mysql-client'
include_middleware 'mysql-server'
include_middleware 'mysql-root-password'
include_middleware 'nginx'

# MySQL

include_middleware 'my_cnf-app'

# Nginx

include_middleware 'nginx/conf/app'

# Services

service 'mysql' do
  action [:enable, :start]
end

service 'nginx' do
  action [:enable, :start]
end
