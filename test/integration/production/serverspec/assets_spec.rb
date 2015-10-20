require 'serverspec'
set :backend, :exec

describe file '/home/certificates/certificates.theodi.org/current/public/assets/' do
  it { should be_directory }
end
