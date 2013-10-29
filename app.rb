require 'teamcity'

set :haml, format: :html5
 
get "/" do
  @projects = TeamCity.projects
  haml :index
end
