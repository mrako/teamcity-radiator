set :haml, format: :html5
 
get "/" do
  @projects = TeamCityWrapper.collect_projects.select{|k| (k[:name] == "Apache Ivy")}

  haml :index
end
