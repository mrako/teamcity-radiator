require "rubygems"

require "sinatra"
require "sinatra/config_file"
require "sinatra/twitter-bootstrap"

require "haml"

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "app/models/*.rb")].each{ |file| require file }

require "./app"

config_file './config.yml'

set :run, false
set :raise_errors, true

TeamCity.configure do |config|
  config.endpoint = settings.teamcity[:endpoint]
  config.http_user = settings.teamcity[:http_user]
  config.http_password = settings.teamcity[:http_password]
end
 
use Rack::CommonLogger

run Sinatra::Application
