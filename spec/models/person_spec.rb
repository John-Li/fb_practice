require 'spec_helper'

describe Person do
  before { @person = Person.new(name: "Example User") }

  subject { @person }

  it { should respond_to(:name) }
  
  describe "when name is not present" do
    before { @person.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @person.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before do
      first_user_with_same_name = @person.dup
      first_user_with_same_name.save
      second_user_with_same_name = @person.dup
      second_user_with_same_name.name = second_user_with_same_name.name.upcase 
      second_user_with_same_name.save
    end

    it { should_not be_valid }
  end
end