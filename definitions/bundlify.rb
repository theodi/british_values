define :bundlify, :params => {} do
  bash 'Configuring bundler' do
    environment(
      'HOME' => "/home/#{params[:name]}"
    )
    cwd params[:cwd]
    user params[:name]
    code <<-EOF
      bundle config build.nokogiri --use-system-libraries
    EOF
  end

  bash 'Bundling the gems' do
    environment(
      'HOME' => "/home/#{params[:name]}"
    )
    cwd params[:cwd]
    user params[:name]
    code <<-EOF
      bundle install \
        --without=development test \
        --quiet \
        --deployment
    EOF
  end
end
