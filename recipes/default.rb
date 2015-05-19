%w{
  ruby1.9.1-dev
  build-essential
  libcurl4-openssl-dev
  libmysqlclient-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'git'
include_recipe 'odi-users::default'
include_recipe 'ruby-ng::default'

deploy_revision '/home/certificates/certificates.theodi.org' do
  repo 'git://github.com/theodi/open-data-certificate'
  user node['user']
  group node['user']
  migrate false
  before_migrate do
    script 'Bundling the gems' do
      interpreter 'bash'
      cwd release_path
      user new_resource.user
      code <<-EOF
        bundle install \
          --without=development test \
          --quiet \
          --deployment
      EOF
    end
  end
end
