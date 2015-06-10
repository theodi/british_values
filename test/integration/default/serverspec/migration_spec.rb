require 'serverspec'
set :backend, :exec

describe command 'mysql -h 10.14.1.111 -u certificates -pcertificates certificates -e "show tables"' do
  its(:stdout) { should match /| Tables_in_certificates/ }
  its(:stdout) { should match /| certificates/ }
  its(:stdout) { should match /| users/ }
end
