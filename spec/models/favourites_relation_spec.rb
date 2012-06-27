require 'spec_helper'

describe FavouritesRelation do
  let(:rob) {mock_model(Person, name: 'Rob')}
  let(:roy) {mock_model(Person, name: 'Roy')}
  let(:favourites_relation) {m = mock_model(FavouritesRelation, favourite_id: rob.id, favourites_id: roy.id); m.as_new_record}
  
  subject { favourites_relation }
  
  before do
    favourites_relation.stub!(:favourite).and_return(rob)
    favourites_relation.stub!(:favourites).and_return(roy)
  end
  
  it { should be_valid }
  it { should respond_to(:favourite) }
  it { should respond_to(:favourites) }
  
  it "when without favourite" do
    m = mock_model(FavouritesRelation, favourite_id: nil, favourites_id: roy.id)
    m.as_new_record.should_not be_valid
  end
  
  it " when without favourites" do
    m = mock_model(FavouritesRelation, favourite_id: rob.id, favourites_id: nil)
    m.as_new_record.should_not be_valid
  end
  
  describe "accessible attributes" do
    it "should not allow access to favourite_id" do
      expect {
        FavouritesRelation.new(favourite_id: rob.id)
      }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end