set :ssh_options, keys: [File.expand_path("../id_rsa.infra")]

server "bastion.speee-sbc", user: "infra", roles: %w(bastion)
server "rproxy.speee-sbc", user: "infra", roles: %w(rproxy)
0.upto(15) do |n|
  server 'app-%03d.speee-sbc' % n, user: "infra", roles: %w(app)
end
