define :precompile_assets, :params => {} do
  bash 'Precompiling assets' do
    cwd params[:cwd]
    user params[:user]
    code <<-EOF
      bundle exec rake assets:precompile
    EOF
  end
end
