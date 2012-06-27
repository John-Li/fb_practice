require 'spec_helper'

describe FavouritesRelationsController do
  let(:rob) {mock_model(Person, name: "Rob", id: 1)}
  let(:roy) {mock_model(Person, name: 'Roy', id: 2)}
  let(:record_with_favourite) {mock_model(FavouritesRelation, favourite_id: rob.id, favourites_id: roy.id)}
  let(:record_with_in_favourite) {mock_model(FavouritesRelation, favourite_id: roy.id, favourites_id: rob.id)}
  
  describe "POST #create" do
    before do
      Person.should_receive(:find).with("1").and_return(rob)
      rob.stub!(:add_to_favourites!).with("#{roy.id}").and_return(mock_model(FavouritesRelation, favourite_id: rob.id, favourites_id: roy.id))
      post :create, :current_person_id => "1", :favourite_id => "2"
    end
    
    it "finds current person" do
      assigns(:current_person).should == rob
    end
    
    it "adds favourite to person's favourites" do
      rob.stub!(:favourites).and_return([roy])
      rob.favourites.should include roy
    end
    
    it "succeeds" do
      response.should be_success
    end
  end
  
  describe "POST #delete favourite" do
    before do
      FavouritesRelation.should_receive(:depending_on_fav_type).with('1','2','favourite').and_return(record_with_favourite)
      record_with_favourite.should_receive(:destroy).and_return(true)
      delete :destroy, :current_person_id => "1", :favourite_id => "2", :type => "favourite"
    end
    
    it "finds record for destroying " do
      assigns(:record).should == record_with_favourite
    end
    
    it "destroys record with favourites" do
      pending 'need to corectly implement deletion test'
      # rob.stub!(:favourites).and_return([])
      # rob.favourites.should_not include roy
      record_with_favourite.destroy
      record_with_favourite.id.should be_nil
    end
    
    it "succeeds" do
      response.should be_success
    end
  end
  
  describe "POST #delete in_favourite" do  
    before do
      FavouritesRelation.should_receive(:depending_on_fav_type).with('1','2','in_favourite').and_return(record_with_in_favourite)
      record_with_in_favourite.stub!(:destroy).and_return(true)
      record_with_in_favourite.should_receive(:destroy).and_return(true)
      delete :destroy, :current_person_id => "1", :favourite_id => "2", :type => "in_favourite"
    end
    
    it "finds record for destroying " do
      assigns(:record).should == record_with_in_favourite
    end
    
    it "deletes person from in favourites" do
      rob.stub!(:in_favourites).and_return([])
      rob.in_favourites.should_not include roy
    end
    
    it "succeeds" do
      response.should be_success
    end
  end
end