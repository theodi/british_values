define :post_deploy, :params => {} do
  commands = params[:name]
  user = params[:user]
  cwd = params[:cwd]

  (commands || []).each do |command|
    bash command do
      cwd cwd
      user user
      code <<-EOF
        RAILS_ENV=#{node['deployment']['rack_env']} #{command}
      EOF
    end
  end
end
