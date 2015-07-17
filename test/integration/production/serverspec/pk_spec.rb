require 'serverspec'
set :backend, :exec

describe file '/home/odi/' do
  it { should be_directory }
end

describe file '/home/odi/.ssh/authorized_keys' do
  it { should be_file }
end
