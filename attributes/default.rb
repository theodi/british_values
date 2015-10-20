default['user'] = 'certificates'
default['fully_qualified_domain_name'] = 'certificates.theodi.org'
default['repo'] = 'theodi/open-data-certificate'
default['start_port'] = 8000
default['concurrency'] = 2
default['concurrency_string'] = "thin=#{node['concurrency']},delayed_job=1,sidekiq=1"
default['catch_and_redirect'] = ['certificate.theodi.org']
default['no_x_forwarded'] = true

default['ruby-ng']['ruby_version'] = '2.0'

default['mysql']['database'] = 'certificates'
default['mysql']['pool'] = 50
default['migrate'] = 'bundle exec rake db:migrate'
default['precompile_assets'] = true
default['post_deploy_tasks'] = ['bundle exec rake odc:deploy']
