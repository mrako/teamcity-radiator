require 'rubygems'
require 'rspec/core/rake_task'
require 'warbler'

include Rake::DSL

task :default => :start

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["--tty", "--colour"]
  t.pattern = 'spec/models/*_spec.rb'
end

task :warble do
  sh "warble"
end

task :start do
  sh "warble"
  sh "java -jar deploy/radiator.war"
end
