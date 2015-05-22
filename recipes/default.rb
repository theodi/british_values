user = node['user']
group = node['user']

include_recipe 'apt'

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

directory "/home/#{user}/.bundle" do
  owner user
  group group
  action :create
end

cookbook_file 'bundle-config' do
  path "/home/#{user}/.bundle/config"
  owner user
  group group
  action :create
end

deploy_revision "/home/#{user}/certificates.theodi.org" do
  repo "git://github.com/#{node['repo']}"
  user user
  group group
  migrate false
  before_migrate do
    script 'Bundling the gems' do
      interpreter 'bash'
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
end
