default['user'] = 'certificates'
default['fully_qualified_domain_name'] = 'certificates.theodi.org'
default['catch_and_redirect'] = ['certificate.theodi.org']
default['start_port'] = 8000
default['concurrency'] = 2
default['repo'] = 'theodi/open-data-certificate'

default['mysql']['database'] = 'certificates'
default['migrate'] = 'bundle exec rake db:migrate'
default['post_deploy_tasks'] = ['bundle exec rake odc:deploy']
default['deployment']['rack_env'] = 'production'
default['deployment']['revision'] = 'CURRENT'

default['envbuilder']['base_dir'] = '/home/certificates'
default['envbuilder']['base_dbi'] = 'development'
default['envbuilder']['owner'] = 'certificates'
default['envbuilder']['group'] = 'certificates'

default['ruby-ng']['ruby_version'] = '1.9.3'
default['ruby-ng']['dev_package'] = '1.9.1'

default['chef_client']['config']['ssl_verify_mode'] = 'verify_none'
default['chef_client']['interval'] = 300
default['chef_client']['splay'] = 60
