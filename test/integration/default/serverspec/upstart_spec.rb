require 'serverspec'
set :backend, :exec

describe file '/var/log/certificates' do
  it { should be_directory }
end

describe file '/var/run/certificates' do
  it { should be_directory }
end

###describe file '/etc/init/certificates.conf' do
###  it { should be_file }
###end
