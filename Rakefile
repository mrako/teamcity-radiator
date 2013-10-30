require 'rubygems'
require 'rspec/core/rake_task'
require 'warbler'

include Rake::DSL

task :default => :warble

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["--tty", "--colour"]
  t.pattern = 'spec/models/*_spec.rb'
end

task :warble do
  sh "warble"
end

namespace :war do
  task :bundle do
    sh "warble"
  end
  
  task :rename_and_copy do
    sh "mv radiator.war jetty/webapps/ROOT.war"
  end
  
  task :start do
    sh "cd jetty; java -Djetty.port=8080 -jar start.jar"
  end
  
  task :deploy => [:bundle, :rename_and_copy, :start]
end
