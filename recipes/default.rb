user = node['user']
group = node['user']
port = node['port']
fqdn = node['fully_qualified_domain_name']

include_recipe 'apt'
include_recipe 'envbuilder'

include_recipe 'british_values::dependencies'

include_recipe 'git'
include_recipe 'nginx'
include_recipe 'odi-pk'
include_recipe 'odi-users::default'
include_recipe 'ruby-ng::default'

include_recipe 'odi-monitoring'

deploy_revision "/home/#{user}/#{fqdn}" do
  repo "git://github.com/#{node['repo']}"
  user user
  group group
  revision node['deployment']['revision']
  migrate node.has_key? :migrate
  migration_command node['migrate']
#  BORK
#    * WE NEED TO db:create FIRST, BUT NOT PER-DEPLOY, SURELY?
#    * ONLY A SINGLE NODE SHOULD DO DEPLOY TASKS - SOMETHING REDIS QUEUE
  action :deploy
  environment(
    'RACK_ENV' => node['deployment']['rack_env']
  )

  before_migrate do
    current_release_directory = release_path

    bash 'Symlink env' do
      cwd release_path
      user user
      code <<-EOF
        ln -sf /home/#{user}/env .env
      EOF
    end

    directory "/home/#{user}/#{fqdn}/shared/config/" do
      action :create
      recursive true
    end

    directory "/home/#{user}/#{fqdn}/shared/log/" do
      action :create
      recursive true
      user user
    end

    template "/home/#{user}/#{fqdn}/shared/config/database.yml" do
      action :create
      variables(
        :mysql_host     => node['mysql']['host'],
        :mysql_database => node['mysql']['database'],
        :mysql_username => node['mysql']['database'],
        :mysql_password => node['mysql']['password']
      )
    end

    bundlify user do
      cwd current_release_directory
    end
  end

  before_restart do
    current_release_directory = release_path

    precompile_assets do
      cwd current_release_directory
      user user
    end

    foremanise user do
      cwd current_release_directory
    end
  end

  after_restart do
    current_release_directory = release_path

    post_deploy node['post_deploy_tasks'] do
      cwd current_release_directory
      user user
    end
  end

  restart_command "sudo service #{user} restart"
end
