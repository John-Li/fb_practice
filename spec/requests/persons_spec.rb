require 'spec_helper'

describe "Persons" do
  let(:roy) {mock_model(Person, name: 'Roy')}
  let(:rob) {mock_model(Person, name: "Rob")}
  let(:sam) {mock_model(Person, name: "Sam")}
  let(:first_favourite) {roy.stub!(:add_to_favourites!).and_return(mock_model(FavouritesRelation, favourite_id: roy.id, favourites_id: rob.id))}
  let(:second_favourite) {roy.stub!(:add_to_favourites!).and_return(mock_model(FavouritesRelation, favourite_id: roy.id, favourites_id: sam.id))}
  
  
  describe "Persons index page" do
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
  
  describe "Person show page" do
    it "should GET the page" do
      get person_path roy
      response.status.should be(200)
    end
  end
  
  describe "Person page" do
    before do
      first_favourite
      second_favourite
      visit person_path roy
    end
    
    it "should have person's name" do
      page.should have_selector(".name .current", text: roy.name)
    end
    
    it "should have person's favourites" do
      page.should have_selector(".favourites a.follow", text: rob.name)
    end
    
    it "should have person's in favourites of" do 
      page.should have_selector(".in_favourites a.follow", text: sam.name)
    end
    
    it "shoud have list of persons for adding to favourites" do
      page.should have_selector("select#favourite")
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
