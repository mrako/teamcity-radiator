# encoding: utf-8

require 'spec_helper'

describe TeamCityWrapper do

  describe "collect_projects" do
    it "should return build type with name and last build status" do
      projects = [OpenStruct.new({id: 1, name: "Tomme"})]

      TeamCity.should_receive(:projects).and_return(projects)

      TeamCityWrapper.should_receive(:collect_buildtypes).with(1).and_return([{name: "Kivikunu", status: "success", start: "21.10.2013 10:00"}])

      projects = TeamCityWrapper.collect_projects.first

      projects[:name].should == "Tomme"
      projects[:types].first[:name].should == "Kivikunu"
      projects[:types].first[:status].should == "success"
      projects[:types].first[:start].should == "21.10.2013 10:00"
    end
  end

  describe "collect_buildtypes" do
    it "should return build type with name and last build status" do
      build_types = [OpenStruct.new({name: "build_111"}), OpenStruct.new({name: "build_222"})]
      TeamCity.should_receive(:project_buildtypes).with(id: "bt11").and_return(build_types)

      TeamCityWrapper.should_receive(:build_info_for_type).twice.and_return({status: "success", start: "21.10.2013 10:00"})

      types = TeamCityWrapper.collect_buildtypes("bt11").first

      types[:name].should == "build_111"
      types[:status].should == "success"
      types[:start].should == "21.10.2013 10:00"
    end
  end

  describe "build_info_for_type" do
    it "should return last succeeding build info" do
      builds = [OpenStruct.new({status: "FAILURE", startDate: "20131002T091700+0400"}), OpenStruct.new({status: "SUCCESS", startDate: "20131006T091800+0400"})]

      TeamCity.should_receive(:builds).with(buildType: "build_123").and_return(builds)

      TeamCityWrapper.build_info_for_type("build_123").should == {:status=>"failure", :start=>"02.10.2013 09:17"}
    end

    it "should return last failing build status" do
      builds = [OpenStruct.new({status: "SUCCESS", startDate: "20131006T091800+0400"})]

      TeamCity.should_receive(:builds).with(buildType: "build_111").and_return(builds)

      TeamCityWrapper.build_info_for_type("build_111").should == {:status=>"success", :start=>"06.10.2013 09:18"}
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
