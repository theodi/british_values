require 'serverspec'
set :backend, :exec

describe file '/etc/cron.d/chef-client' do
  it { should be_file }
  its(:content) { should match /\/usr\/bin\/chef-client/ }
  its(:content) { should_not match /\/var\/log\/chef\/cron.log/ }
end

describe file '/etc/chef/client.rb' do
  it { should be_file }
#  its(:content) { should match /chef_server_url  "https:\/\/chef.theodi.org"/ }
  its(:content) { should match /validation_client_name "chef-validator"/ }
end
