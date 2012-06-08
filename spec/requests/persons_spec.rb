require 'spec_helper'

describe "Persons" do
  describe "GET /persons" do
    it "should GET the page" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get persons_path
      response.status.should be(200)
    end
    
    it "should have the content 'Name'" do
      visit "/persons"
      page.should have_content('Name')
    end
    
    it "should have the right title" do
      visit '/persons'
      page.should have_selector('title', text: 'Retailers')
    end
  end
end
