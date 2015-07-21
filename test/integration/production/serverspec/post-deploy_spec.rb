require 'serverspec'
require 'spec_helper'
set :backend, :exec

describe command "cd /home/certificates/certificates.theodi.org/current && RAILS_ENV=production bundle exec rails runner 'Survey.count > 1 or exit(1)'" do
  its(:exit_status) { should eq 0 }
end
