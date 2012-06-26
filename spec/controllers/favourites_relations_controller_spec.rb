require 'spec_helper'

describe FavouritesRelationsController do
  let(:current_person) {mock_model(Person, name: 'Rob', id: 1)}
  let(:favourite) {mock_model(Person, name: 'Roy', id: 2)}
  
  describe "POST #create" do
    before do
      Person.should_receive(:find).with("1").and_return(current_person)
      Person.should_receive(:find).with("2").and_return(favourite)
      current_person.stub!(:add_to_favourites!).with(favourite).and_return(true)
      post :create, :current_person_id => "1", :favourite_id => "2"
    end
    
    it "succeeds" do
      pending
      response.status.should be(200)
    end
    it "finds current person" do
      assigns(:current_person).should == current_person
    end
    it "finds a favourite"
    it "adds favourite to person's favourites"
  end
  
  describe "POST #delete" do
    
    it "deletes person from favourites" do
      post :delete
    end
    
    it "deletes person from in favourites" do
      post :delete
    end
  end
end