define :foremanise, :params => {} do
  %w[ log run ].each do |subdir|
    bash 'Make dirs for Foreman' do
      user 'root'
      code <<-EOF
        mkdir -p /var/#{subdir}/#{params[:name]}
        chown #{params[:name]} /var/#{subdir}/#{params[:name]}
      EOF
    end
  end

  bash 'Generate startup scripts with Foreman' do
    cwd params[:cwd]
    user params[:name]
    code <<-EOF
      bundle exec foreman export \
        -a #{params[:name]} \
        -u #{params[:name]} \
        -p #{params[:port]} \
        -c thin=#{params[:concurrency]},delayed_job=1,sidekiq=1 \
        -e #{params[:cwd]}/.env \
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
