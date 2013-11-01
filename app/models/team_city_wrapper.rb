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
        types << {name: b.name, href: b.webUrl}.merge(build_info_for_type(b.id))
      }
    end
  end

  def self.build_info_for_type(id)
    builds = TeamCity.builds(buildType: id)
    Hash.new.tap { |build|
      build[:status] = (builds.empty? ? "empty" : builds.first.status.downcase)
      build[:start] = build_date(builds)
    }
  end

  def self.build_date(builds)
    return if builds.empty?
    time = DateTime.parse(builds.first.startDate)

    time.strftime("%d.%m.%Y %H:%M") if time
  end

  def self.projects
    TeamCity.projects.reject{|k| k.id == "_Root"}.select{|k| (k[:name] == "Apache Ivy")}
  end
end
