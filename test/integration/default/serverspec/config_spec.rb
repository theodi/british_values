require 'serverspec'
set :backend, :exec

describe file '/home/certificates/certificates.theodi.org/shared/config/database.yml' do
  it { should be_file }
  its(:content) { should match /production:/ }
  its(:content) { should match /adapter: mysql2/ }
  its(:md5sum) { should eq '8595866cc7855389efe8f34ff22040da' }
end
