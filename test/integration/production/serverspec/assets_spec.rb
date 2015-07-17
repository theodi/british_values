require 'serverspec'
set :backend, :exec

describe file '/home/certificates/certificates.theodi.org/current/public/assets/application.css' do
  it { should be_file }
end
