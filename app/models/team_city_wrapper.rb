require 'teamcity'

class TeamCityWrapper
  def self.collect_projects
    Array.new.tap do |projs|
      projects.each do |p|
        projs << {name: p.name, types: collect_buildtypes(p.id)}
      end
    end
  end

  def self.collect_buildtypes(id)
    Array.new.tap do |types|
      TeamCity.project_buildtypes(id: id).each { |b|
        types << {name: b.name, status: build_status_for_type(b.id)}
      }
    end
  end

  def self.build_status_for_type(id)
    builds = TeamCity.builds(buildType: id)

    builds.empty? ? "empty" : builds.last.status.downcase
  end

  def self.projects
    TeamCity.projects.reject{|k| k.id == "_Root"}.select{|k| (k[:name] == "Apache Ivy")}
  end
end
