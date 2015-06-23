define :post_deploy, :params => {} do
  (params[:name] || []).each do |command|
    bash command do
      cwd params[:cwd]
      user params[:user]
      code <<-EOF
        RAILS_ENV=#{node['deployment']['rack_env']} #{command}
      EOF
    end
  end
end
