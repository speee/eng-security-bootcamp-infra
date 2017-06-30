# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "speee-sbc-infra"
set :repo_url, "git@github.com:speee/eng-security-bootcamp-infra.git"
set :deploy_to, "/home/infra/speee-sbc-infra"
set :pty, true
