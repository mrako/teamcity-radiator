require "rubygems"

require "teamcity"

TeamCity.configure do |config|
  config.endpoint = ""
  config.http_user = "guest"
  config.http_password = "guest"
end

p TeamCity.projects.reject{ |k| k.id == "_Root" }
