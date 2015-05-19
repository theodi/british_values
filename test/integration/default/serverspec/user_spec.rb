require 'serverspec'
set :backend, :exec

describe user('certificates') do
  it { should exist }
end
