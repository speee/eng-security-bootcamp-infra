desc "Report current deployed revision"
task :current_revision do
  on roles(:all) do
    within current_path do
      execute :cat, 'REVISION'
    end
  end
end
