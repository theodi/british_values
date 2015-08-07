require 'serverspec'
require 'spec_helper'
set :backend, :exec

describe command "cd /home/certificates/certificates.theodi.org/current && RAILS_ENV=production bundle exec rails runner 'Certificate.first'" do
  its(:exit_status) { should eq 0 }
end
