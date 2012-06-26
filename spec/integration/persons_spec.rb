require 'spec_helper'

describe "Person" do
    let(:rob) { Person.create(name: "Rob") }
    let(:roy) { Person.create(name: "Roy") }
    let(:sam) { Person.create(name: "Sam") }
    let(:max) { Person.create(name: "Max") }
    let(:bob) { Person.create(name: "Bob") }
    let(:joe) { Person.create(name: "Joe") } 
  
  before do
    rob.add_to_favourites!(roy)
    rob.add_to_favourites!(sam)
    max.add_to_favourites!(rob)
    bob.add_to_favourites!(rob)
  end
  
  it "sees all of the people" do
    pending
    visit persons_path
    page.should have_selector('td.name a', text: rob.name)
    page.should have_selector('td.name a', text: roy.name)
    page.should have_selector('td.name a', text: sam.name)
    page.should have_selector('td.name a', text: max.name)
    page.should have_selector('td.name a', text: bob.name)
    page.should have_selector('td.name a', text: joe.name)
  end
  
  it "can take look at any person in the list" do
    pending
    visit persons_path
    click_link('Rob')
    page.should have_selector('.name .current', text: 'Rob')
  end
  
  it "can visit its favourites page" do
    pending
    visit person_path rob
    within('.favourites') do
      click_link('Roy')
    end  
    page.should have_selector('.name .current', text: 'Roy')
  end
  
  it "can visit its in favourites page" do
    pending
    visit person_path rob
    within('.in_favourites') do
      click_link('Max')
    end
    page.should have_selector('.name .current', text: 'Max')  
  end
  
  it "can add a new person to his favourites" do
    pending
    visit person_path rob 
    page.select('Joe', from: "favourite_id")
    page.has_selector?(".flash .notice", text: 'Successfully added Joe to favourites')
  end
  
  it "can delete the person from his favourites" do
    pending
    visit person_path rob 
    within('.favourites') do
      has_selector?('a.follow', text: 'Roy')
      click_link('delete_favourite')
    end
    page.has_no_selector?('a.follow', text: 'Roy')
    page.has_selector?('.flash .notice', text: 'Successfully deleted from favourites')
  end
  
  it "can delete self from someone's favourites", js: true do
    pending
    visit person_path rob 
    save_and_open_page
    # print find('.in_favourites').text
    # within('.in_favourites') do
    #   has_selector?('a.follow', text: 'Max')
    #   click_link('delete_in_favourite')
    # end
    # page.has_no_selector?('a.follow', text: 'Max')
    # page.has_selector?('.flash .notice', text: 'Successfully deleted self from favourites')
    # print page.html
  end
end