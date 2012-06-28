require 'spec_helper'

describe FavouritesRelationsController do
  let(:rob) {create(:person, name: "Rob")}
  let(:roy) {create(:person, name: 'Roy')}
  let(:record_with_favourite) {mock_model(FavouritesRelation, favourite_id: rob.id, favourites_id: roy.id) } #rob.favourites_relations.create(favourites_id: roy.id)
  let(:record_with_in_favourite) {mock_model(FavouritesRelation, favourite_id: roy.id, favourites_id: rob.id)} #roy.favourites_relations.create(favourites_id: rob.id)
  
  describe "POST #create" do
    before do
      @hash = {:current_person_id => rob.id, :favourite_id => roy.id}
    end
    
    it "returns needed values" do
      Person.should_receive(:find).with("#{rob.id}").and_return(rob)
      rob.should_receive(:add_to_favourites!).with("#{roy.id}").and_return(record_with_favourite)
      post :create, @hash
    end  
    
    it "finds current person" do
      post :create, @hash
      assigns(:current_person).should == rob
    end
    
    it "adds favourite to person's favourites" do
      expect {post :create, @hash}.to change(FavouritesRelation, :count).by(1)
    end
    
    it "succeeds" do
      post :create, @hash
      response.should be_success
    end
  end
  
  describe "POST #delete favourite" do
    before do
      @hash = {:current_person_id => rob.id, :favourite_id => roy.id, :type => "favourite"}
      @record = rob.add_to_favourites!(roy.id)
    end
    
    it "returns right values" do
      FavouritesRelation.should_receive(:depending_on_fav_type).with('1','2','favourite').and_return(record_with_favourite)
      record_with_favourite.should_receive(:destroy).and_return(true)
      delete :destroy, @hash
    end
    
    it "finds record for destroying " do
      delete :destroy, @hash
      assigns(:record).should == @record
    end
    
    it "destroys record with favourites" do
      expect {delete :destroy, @hash}.to change(FavouritesRelation, :count).by(-1)
    end
    
    it "succeeds" do
      delete :destroy, @hash
      response.should be_success
    end
  end
  
  describe "POST #delete in_favourite" do  
    before do
      @hash = {:current_person_id => rob.id, :favourite_id => roy.id, :type => "in_favourite"}
      @record = roy.add_to_favourites!(rob.id)
    end
    
    it "returns right values" do
      FavouritesRelation.should_receive(:depending_on_fav_type).with('1','2','in_favourite').and_return(record_with_in_favourite)
      record_with_in_favourite.should_receive(:destroy).and_return(true)
      delete :destroy, @hash
    end
    
    it "finds record for destroying " do
      delete :destroy, @hash
      assigns(:record).should == @record
    end
    
    it "deletes person from in favourites" do
      expect {delete :destroy, @hash}.to change(FavouritesRelation, :count).by(-1)
    end
    
    it "succeeds" do
      delete :destroy, @hash
      response.should be_success
    end
  end
end