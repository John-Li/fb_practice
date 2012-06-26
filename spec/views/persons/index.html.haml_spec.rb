require 'spec_helper'
require 'will_paginate/array'

describe "persons/index" do
  let(:rob) {mock_model(Person, name: "Rob", id: 1)}
  let(:roy) {mock_model(Person, name: 'Roy', id: 2)}
  let(:sam) {mock_model(Person, name: "Sam", id: 3)}
  let(:max) {mock_model(Person, name: "Max", id: 4)}
  
  before do
   assign(:people, [rob, roy, sam, max].paginate(:page => 1, :per_page => 15))
   render
  end
  
  it "infers the controller path" do
    controller.request.path_parameters[:controller].should eq("persons")
  end
  
  it "infers the action path" do
    controller.request.path_parameters[:action].should eq("index")
  end
  
  it "displays all the persons" do
    rendered.should have_selector('.name a', text: rob.name)
    rendered.should have_selector('.name a', text: roy.name)
  end
  
  it "displays persons id's" do
    rendered.should have_selector('td.id', text: sam.id.to_s)
    rendered.should have_selector('td.id', text: max.id.to_s)
  end
end