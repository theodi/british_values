require 'serverspec'
set :backend, :exec

describe package('ruby1.9.3') do
  it { should be_installed }
end
