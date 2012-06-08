require 'spec_helper'

describe Person do
  let(:person) { build(:person) }
  let(:person_with_the_same_name) {create(:person)}
  let(:person_with_the_same_name_upcased) {create(:person, name: person_with_the_same_name.name.upcase)}
  
  subject { person }

  it { should respond_to(:name) }
  
  describe "when name is not present" do
    before { person.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { person.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before do
      person_with_the_same_name
      person_with_the_same_name_upcased 
    end
    
    it { should_not be_valid }
  end
end