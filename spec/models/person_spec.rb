require 'spec_helper'

describe Person do
  let(:person) { build(:person) }
  
  subject { person }

  it { should respond_to(:name) }
  it { should respond_to(:favourites_relations) }
  it { should respond_to(:favourites) }
  it { should respond_to(:in_favourites) }
  it { should respond_to(:add_to_favourites!) }
  it { should respond_to(:delete_from_favourites!) }
  it { should respond_to(:has_in_favourites?) }
  
  describe "when name is not present" do
    before { person.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { person.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when the name is already taken" do
    before do 
      person_with_the_same_name = person.dup 
      person_with_the_same_name.save
    end
    it { should_not be_valid }
  end
  
  describe "when addind to favourites other person" do
    let(:other_person) { create(:person, name: 'YAN') }    
    before do
      person.save
      person.add_to_favourites!(other_person)
    end

    it { should be_has_in_favourites(other_person) }
    its(:favourites) { should include(other_person) }
    
    describe "when deleting from favourites other person" do
      before { person.delete_from_favourites!(other_person) }
      
      it { should_not be_has_in_favourites(other_person) }
      its(:favourites) { should_not include(other_person) }
    end
  end
end