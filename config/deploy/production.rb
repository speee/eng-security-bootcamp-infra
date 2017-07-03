set :ssh_options, keys: [File.expand_path("../id_rsa.infra")]

server "bastion.speee-sbc", user: "infra", roles: %w(bastion)
server "rproxy.speee-sbc", user: "infra", roles: %w(rproxy)
server "app-000.speee-sbc", user: "infra", roles: %w(app)
