user = node['user']
group = node['user']
port = node['port']

include_recipe 'apt'
include_recipe 'envbuilder'

%w{
  build-essential
  libcurl4-openssl-dev
  libmysqlclient-dev
  libxml2-dev
  libxslt1-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end

package "ruby#{node['dev_package']}-dev" do
  action :install
end

include_recipe 'git'
include_recipe 'odi-users::default'
include_recipe 'ruby-ng::default'

deploy_revision "/home/#{user}/certificates.theodi.org" do
  repo "git://github.com/#{node['repo']}"
  user user
  group group
  revision node['deployment']['revision']
  migrate node.has_key? :migrate
  migration_command node['migrate']
#  BORK
#    * WE NEED TO db:create FIRST, BUT NOT PER-DEPLOY, SURELY?
#    * ONLY A SINGLE NODE SHOULD DO DEPLOY TASKS - SOMETHING REDIS QUEUE
  action :force_deploy
  environment(
    'RACK_ENV' => node['deployment']['rack_env']
  )

  before_migrate do
    bash 'Symlink env' do
      cwd release_path
      user user
      code <<-EOF
        ln -sf /home/#{user}/env .env
      EOF
    end

    directory "/home/#{user}/certificates.theodi.org/shared/config/" do
      action :create
      recursive true
    end

    directory "/home/#{user}/certificates.theodi.org/shared/log/" do
      action :create
      recursive true
      user user
    end

    template "/home/#{user}/certificates.theodi.org/shared/config/database.yml" do
      action :create
      variables(
        :mysql_host     => node['mysql']['host'],
        :mysql_database => node['mysql']['database'],
        :mysql_username => node['mysql']['database'],
        :mysql_password => node['mysql']['password']
      )
    end

    bash 'Configuring bundler' do
      environment(
        'HOME' => "/home/#{user}"
      )
      cwd release_path
      user user
      code <<-EOF
        bundle config build.nokogiri --use-system-libraries
      EOF
    end

    bash 'Bundling the gems' do
      environment(
        'HOME' => "/home/#{user}"
      )
      cwd release_path
      user user
      code <<-EOF
        bundle install \
          --without=development test \
          --quiet \
          --deployment
      EOF
    end
  end

  before_restart do
    bash 'Precompiling assets' do
      cwd release_path
      user user
      code <<-EOF
        bundle exec rake assets:precompile
      EOF
    end

    %w[ log run ].each do |subdir|
      bash 'Make dirs for Foreman' do
        user 'root'
        code <<-EOF
          mkdir -p /var/#{subdir}/#{user}
          chown #{user} /var/#{subdir}/#{user}
        EOF
      end
    end

    bash 'Generate startup scripts with Foreman' do
      cwd release_path
      user user
      code <<-EOF
        bundle exec foreman export \
          -a #{user} \
          -u #{user} \
          -p 8000 \
          -c thin=2,delayed_job=1 \
          -e #{cwd}/.env \
          upstart /tmp/init
      EOF
    end

    bash 'Copy startup scripts into the right place' do
      user 'root'
      code <<-EOF
        mv /tmp/init/* /etc/init/
      EOF
    end
  end

  restart_command "sudo restart #{user}"
end
