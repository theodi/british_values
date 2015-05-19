require 'serverspec'
set :backend, :exec

%w{
  ruby1.9.1-dev
  build-essential
  libcurl4-openssl-dev
  libmysqlclient-dev
}.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe file '/home/certificates/certificates.theodi.org' do
  it { should be_directory }
  it { should be_owned_by 'certificates' }
end

describe file '/home/certificates/certificates.theodi.org/current/vendor/bundle' do
  it { should be_directory }
  it { should be_owned_by 'certificates' }
end
