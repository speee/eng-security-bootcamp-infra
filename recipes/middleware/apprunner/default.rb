group "apprunner" do
  gid 600
end

user "apprunner" do
  uid 600
  gid 600
  create_home true
end
