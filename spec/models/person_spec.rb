require 'spec_helper'

describe Person do
  let(:bob) { build(:person, name: 'Bob') }
  let(:jan) { create(:person, name: 'Jan') } 
  
  subject { bob }

  it { should respond_to(:name) }
  it { should respond_to(:favourites_relations) }
  it { should respond_to(:favourites) }
  it { should respond_to(:in_favourites) }
  it { should respond_to(:add_to_favourites!) }
  
  describe "when name is not present" do
    before { bob.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { bob.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when the name is already taken" do
    before do 
      person_with_the_same_name = bob.dup 
      person_with_the_same_name.save
    end
    it { should_not be_valid }
  end
  
  describe "when adding to favourites other person" do
    it "should have it in favourites" do
      bob.save
      bob.add_to_favourites!(jan.id)
      bob.favourites.should include jan
    end
  end
  
  describe "when deleting from favourites other person" do
    it "should not have it in favourites" do
      bob.save
      bob.add_to_favourites!(jan.id)
      bob.favourites.find_by_id(jan.id).destroy
      bob.favourites.should_not include jan
    end
  end
end