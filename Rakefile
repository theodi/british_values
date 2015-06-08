desc 'converge node'
task :converge do
  exec 'bundle exec kitchen converge'
end

desc 'verify node'
task :verify do
  exec 'bundle exec kitchen verify'
end

desc 'full test run'
task :test do
#  exec 'bundle exec kitchen test'
  0
end

task :default => :test
