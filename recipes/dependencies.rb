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

if node['ruby-ng']['dev_package']
  package "ruby#{node['dev_package']}-dev" do
    action :install
  end
end
