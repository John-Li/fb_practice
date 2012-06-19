require 'spec_helper'

describe "Persons" do
  let(:roy) {create(:person)}
  let(:rob) {create(:person, name: "Rob")}
  let(:sam) {create(:person, name: "Sam")}
  
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
  
  describe "GET /persons/:id" do
    it "should GET the page" do
      get person_path roy
      response.status.should be(200)
    end
  end
  
  describe "when deleting somebody from favourites/in_favourites" do  
    before do
      #puts rob.name
      #puts sam.name 
      [rob,sam].each {|friend| roy.add_to_favourites!(friend)} 
    end
    
    it "should change the count" do
      lambda do
        visit person_path roy
        click_link('delete_favourite') 
      end.should change(FavouritesRelation, :count).by(1)
    end
    
    it "should show the flash confirmation message" do
      visit person_path roy
      click_link('delete_favourite')
      response.should have_selector(".flash .notice", :content => "Successfully deleted from favourites")
    end
  end
end
