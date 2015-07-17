require 'serverspec'
set :backend, :exec

describe service 'chef-client' do
  it { should be_running }
end

describe file '/etc/chef/client.rb' do
  it { should be_file }
#  its(:content) { should match /chef_server_url  "https:\/\/chef.theodi.org"/ }
  its(:content) { should match /validation_client_name "chef-validator"/ }
end
