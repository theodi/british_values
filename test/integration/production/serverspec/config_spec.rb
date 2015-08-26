require 'serverspec'
set :backend, :exec

describe file '/home/certificates/certificates.theodi.org/shared/config/database.yml' do
  it { should be_file }
  its(:content) { should match /production:/ }
  its(:content) { should match /adapter: mysql2/ }
  its(:content) { should match /pool: 50/ }
  its(:md5sum) { should eq 'eb4943bb770b84245567accda87a420a' }
end
