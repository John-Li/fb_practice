require 'spec_helper'

describe FavouritesRelation do
  let(:favourite)  {create(:person)}
  let(:favourites) {create(:person, name: 'Rob')}
  let(:favourites_relation) {favourite.favourites_relations.new(favourites_id: favourites.id)}
  
  subject { favourites_relation }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to favourite_id" do
      expect do
        FavouritesRelation.new(favourite_id: favourite.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "favourites_relations methods" do 
    it { should respond_to(:favourite) }
    it { should respond_to(:favourites) }
  end
  
  describe "when favourite id is not present" do
    before { favourites_relation.favourite_id = nil }
    it { should_not be_valid }
  end

  describe "when favourites id is not present" do
    before { favourites_relation.favourites_id = nil }
    it { should_not be_valid }
  end
end