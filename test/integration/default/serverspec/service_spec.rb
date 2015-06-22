require 'serverspec'
set :backend, :exec

describe service 'certificates-thin-2' do
  it { should be_running }
end

describe port(8001) do
  it { should be_listening }
end

describe command 'wget --server-response -O/dev/null http://localhost:8001 |\& grep "^  "' do
  its(:stdout) { should match /200 OK/ }
end
