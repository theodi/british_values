desc 'converge node'
task :converge do
  exec 'bundle exec kitchen converge'
end

desc 'verify node'
task :converge do
  exec 'bundle exec kitchen verify'
end

desc 'full test run'
task :test do
  exec 'bundle exec kitchen test'
end

task :default => :test
