Warbler::Config.new do |config|
  config.autodeploy_dir = "deploy"
  config.jar_name = "radiator"
  config.dirs = %w(app config public views)
  config.includes = FileList["app.rb", "config.yml"]
  config.gems += ["sinatra", "sinatra-contrib", "haml", "teamcity-ruby-client"]
  config.gems -= ["rails"]
  config.gem_dependencies = true
  config.features = %w(executable)
end
