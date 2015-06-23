define :foremanise, :params => {} do
  name = params[:name]
  user = params[:name]
  cwd = params[:cwd]
  port = params[:port]
  concurrency = params[:concurrency]

  %w[ log run ].each do |subdir|
    bash 'Make dirs for Foreman' do
      user 'root'
      code <<-EOF
        mkdir -p /var/#{subdir}/#{user}
        chown #{user} /var/#{subdir}/#{user}
      EOF
    end
  end

  bash 'Generate startup scripts with Foreman' do
    cwd cwd
    user user
    code <<-EOF
      bundle exec foreman export \
        -a #{user} \
        -u #{user} \
        -p #{port} \
        -c thin=#{concurrency},delayed_job=1 \
        -e #{cwd}/.env \
        upstart /tmp/init
    EOF
  end

  bash 'Copy startup scripts into the right place' do
    user 'root'
    code <<-EOF
      mv /tmp/init/* /etc/init/
    EOF
  end
end
