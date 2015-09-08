default['user'] = 'certificates'
default['fully_qualified_domain_name'] = 'certificates.theodi.org'
default['catch_and_redirect'] = ['certificate.theodi.org']
default['start_port'] = 8000
default['concurrency'] = 2
default['repo'] = 'theodi/open-data-certificate'

default['mysql']['database'] = 'certificates'
default['mysql']['pool'] = 50
default['migrate'] = 'bundle exec rake db:migrate'
default['post_deploy_tasks'] = ['bundle exec rake odc:deploy']
default['deployment']['rack_env'] = 'production'
default['deployment']['revision'] = 'CURRENT'

default['envbuilder']['base_dir'] = '/home/certificates'
default['envbuilder']['owner'] = 'certificates'
default['envbuilder']['group'] = 'certificates'

default['ruby-ng']['ruby_version'] = '2.0'

default['chef_client']['init_style'] = 'none'
default['chef_client']['cron']['use_cron_d'] = true
default['chef_client']['cron']['hour'] = '*'
default['chef_client']['cron']['minute'] = '*/10'
# I THINK THIS IS BOGUS
default['chef_client']['cron']['log_file'] = '/var/log/chef/cron.log'
