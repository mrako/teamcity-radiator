require 'rubygems'

require 'sinatra'
require 'rack/test'

set :environment, :test

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "../app/models/*.rb")].each{ |file| require file }
