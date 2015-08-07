require 'serverspec'
set :backend, :exec

describe file '/var/log/certificates' do
  it { should be_directory }
end

describe file '/var/run/certificates' do
  it { should be_directory }
end

describe file '/etc/init/certificates.conf' do
  it { should be_file }
  its(:content) { should match /start on runlevel \[2345\]/ }
end

describe file '/etc/init/certificates-thin.conf' do
  it { should be_file }
  its(:content) { should match /start on starting certificates/ }
  its(:md5sum) { should eq 'a41e8fa9b4474c007dc09a5a122e088b' }
end

describe file '/etc/init/certificates-thin-2.conf' do
  it { should be_file }
  its(:content) { should match /start on starting certificates-thin/ }
  its(:content) { should match /exec su - certificates -c/ }
  its(:content) { should match /PORT=8001/ }
  its(:content) { should match /RACK_ENV=production/ }
  its(:content) { should match /RAILS_ENV=production/ }
  its(:content) { should match /bundle exec thin start -p \$PORT >> \/var\/log\/certificates\/thin-2.log 2>&1/ }
end

describe file '/etc/init/certificates-sidekiq-1.conf' do
  it { should be_file }
end
