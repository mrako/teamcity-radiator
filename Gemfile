source "https://rubygems.org"

gem "sinatra"
gem "sinatra-contrib"
gem "sinatra-twitter-bootstrap", :require => "sinatra/twitter-bootstrap"

gem "haml"

gem "teamcity-ruby-client"

platforms :jruby do
  gem "jruby-openssl", :require => false
end

group :test, :development do
  gem "zip-zip"
  gem "warbler"

  gem "rack-test"
  gem "rspec"
end
