define :precompile_assets, :params => {} do
  user = params[:user]
  cwd = params[:cwd]

  bash 'Precompiling assets' do
    cwd cwd
    user user
    code <<-EOF
      bundle exec rake assets:precompile
    EOF
  end
end
