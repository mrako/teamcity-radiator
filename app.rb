set :haml, format: :html5
 
get "/" do
  @projects = TeamCityWrapper.collect_projects

  haml :index
end
