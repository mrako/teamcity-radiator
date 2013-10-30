Warbler::Config.new do |config|
  config.autodeploy_dir = "deploy"
  config.jar_name = "radiator"
  config.dirs = %w(app config public views)
  # config.includes = FileList["init.rb"]
  config.gems += ["jruby-openssl", "sinatra", "sinatra-contrib", "haml", "teamcity-ruby-client"]
  config.gems -= ["rails"]
  config.gem_dependencies = true
end
