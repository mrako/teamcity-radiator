require 'teamcity'

set :haml, format: :html5
 
get "/" do
  @projects = TeamCity.projects.reject{|k| k.id == "_Root"}.select{|k| (k.name == "Apache Ivy")}
  @jobs = @states = {}

  @projects.each do |p|
    @jobs[p.id] = TeamCity.project_buildtypes(id: p.id)
    TeamCity.project_buildtypes(id: p.id).each { |bt|
      @states[bt.id] = TeamCity.builds(buildType: bt.id).last.status == "SUCCESS" ? "green" : "red"
    }
  end

  haml :index
end
