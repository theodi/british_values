define :bundlify, :params => {} do
  name = params[:name]
  user = params[:name]
  cwd = params[:cwd]

  bash 'Configuring bundler' do
    environment(
      'HOME' => "/home/#{user}"
    )
    cwd cwd
    user user
    code <<-EOF
      bundle config build.nokogiri --use-system-libraries
    EOF
  end

  bash 'Bundling the gems' do
    environment(
      'HOME' => "/home/#{user}"
    )
    cwd cwd
    user user
    code <<-EOF
      bundle install \
        --without=development test \
        --quiet \
        --deployment
    EOF
  end
end
