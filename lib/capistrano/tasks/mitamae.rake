set :mitamae_dry_run, false

namespace :mitamae do
  desc "mitamae dry-run"
  task 'dry-run' do
    set :mitamae_dry_run, true
    invoke 'mitamae:apply'
  end

  desc "mitamae apply"
  task :apply do
    on roles(:all) do |server|
      within current_path do
        recipes = server.roles.map {|r| "recipes/roles/#{r}.rb" }
        dry_run = []
        dry_run << '-n' if fetch(:mitamae_dry_run)
        execute :sudo, 'bin/mitamae-x86_64-linux', 'local', *dry_run, 'bootstrap.rb', *recipes
      end
    end
  end
end
