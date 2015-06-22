require 'serverspec'
set :backend, :exec

describe package 'sd-agent' do
  it { should be_installed }
end

describe service 'sd-agent' do
  it { should be_running }
end
