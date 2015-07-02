define :make_vhosts, :params => {} do
  vhosts_dir = "%s/vhosts" % [
    params[:cwd]
  ]

  vh = "%s/%s" % [
    vhosts_dir,
    params[:fqdn]
  ]

  directory vhosts_dir do
    action :create
    owner params[:user]
  end

  template vh do
    source "vhost.erb"
    variables(
      :servername         => node['user'],
      :port               => node['start_port'],
      :concurrency        => node['concurrency'],
      :fqdn               => node['fully_qualified_domain_name'],
      :prefix             => begin node['deployment']['nginx']['prefix'] rescue nil end,
      :catch_and_redirect => node['catch_and_redirect']
    )
    action :create
  end

  file '/etc/nginx/sites-enabled/000-default' do
    action :delete
  end

  link "/etc/nginx/sites-enabled/%s" % [
      File.basename(vh)
  ] do
    to vh
  end
end
