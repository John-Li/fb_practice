require 'spec_helper'

describe "persons/show" do
  let(:rob) {mock_model(Person, name: "Rob", id: 1)}
  let(:roy) {mock_model(Person, name: 'Roy', id: 2)}
  let(:sam) {mock_model(Person, name: "Sam", id: 3)}
  let(:max) {mock_model(Person, name: "Max", id: 4)}
  let(:bob) {mock_model(Person, name: "Bob", id: 5)}
  
  before do
   assign(:person, rob)
   assign(:person_favourites, [roy, sam].paginate(:page => 1, :per_page => 15))
   assign(:person_in_favourites, [roy, sam, max].paginate(:page => 1, :per_page => 15))
   assign(:people_without_self_and_favourites, [max, bob])
   assign(:pagination_collection, [roy, sam, max].paginate(:page => 1, :per_page => 15))
   render
  end
  
  it "infers the controller path" do
    controller.request.path_parameters[:controller].should eq("persons")
  end
  
  it "infers the action path" do
    controller.request.path_parameters[:action].should eq("show")
  end
  
  it "displays person's name" do
    rendered.should have_selector('.name .current', text: rob.name)
  end
  
  it "displays person's favourites" do
    rendered.should have_selector('.favourites a', text: roy.name)
    rendered.should have_selector('.favourites a', text: sam.name)
  end
  
  it "displays person's in favourites of" do
    rendered.should have_selector('.in_favourites a', text: roy.name)
    rendered.should have_selector('.in_favourites a', text: sam.name)
    rendered.should have_selector('.in_favourites a', text: max.name)
  end
  
  it "displays selector of people for adding to favourites" do
    rendered.should have_selector('select#favourite_id option', text: '')
    rendered.should have_selector('select#favourite_id option', text: max.name)
    rendered.should have_selector('select#favourite_id option', text: bob.name)
  end
end