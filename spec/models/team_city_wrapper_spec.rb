# encoding: utf-8

require 'spec_helper'

describe TeamCityWrapper do

  describe "collect_projects" do
    it "should return build type with name and last build status" do
      projects = [OpenStruct.new({id: 1, name: "Tomme"})]

      TeamCity.should_receive(:projects).and_return(projects)

      TeamCityWrapper.should_receive(:collect_buildtypes).with(1).and_return([{name: "Kivikunu", status: "green"}])

      projects = TeamCityWrapper.collect_projects.first

      projects[:name].should == "Tomme"
      projects[:types].first[:name].should == "Kivikunu"
      projects[:types].first[:status].should == "green"
    end
  end

  describe "collect_buildtypes" do
    it "should return build type with name and last build status" do
      build_types = [OpenStruct.new({name: "build_111"}), OpenStruct.new({name: "build_222"})]
      TeamCity.should_receive(:project_buildtypes).with(id: "bt11").and_return(build_types)

      TeamCityWrapper.should_receive(:build_status_for_type).twice.and_return("green")

      types = TeamCityWrapper.collect_buildtypes("bt11").first

      types[:name].should == "build_111"
      types[:status].should == "green"
    end
  end

  describe "build_status_for_type" do
    it "should return last succeeding build status" do
      builds = [OpenStruct.new({status: "FAILURE"}), OpenStruct.new({status: "SUCCESS"})]

      TeamCity.should_receive(:builds).with(buildType: "build_123").and_return(builds)

      TeamCityWrapper.build_status_for_type("build_123").should == "green"
    end

    it "should return last failing build status" do
      builds = [OpenStruct.new({status: "FAILURE"})]

      TeamCity.should_receive(:builds).with(buildType: "build_111").and_return(builds)

      TeamCityWrapper.build_status_for_type("build_111").should == "red"
    end
  end

  describe "projects" do
    it "should return an array" do
      projects = [OpenStruct.new({id: 1, name: "Tomme"})]

      TeamCity.should_receive(:projects).and_return(projects)

      TeamCityWrapper.projects.should == projects
    end
  end
end
