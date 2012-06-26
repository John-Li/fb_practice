require 'spec_helper'
require 'will_paginate/array'

describe PersonsController do
  let(:rob) {mock_model(Person, name: "Rob", id: 1)}
  let(:roy) {mock_model(Person, name: 'Roy', id: 2)}
  let(:sam) {mock_model(Person, name: "Sam", id: 3)}
  let(:max) {mock_model(Person, name: "Max", id: 4)}
  
  describe "GET #index" do
    before do
      Person.should_receive(:all).and_return([rob,roy,sam,max])
      get :index  
    end
    
    it "has a 200 status code" do
      response.status.should be(200)
    end
    it "finds all people" do
      assigns(:people).should == [rob,roy,sam,max]
    end
    it "renders index template" do
      response.should render_template('index')
    end
  end
  
  describe "GET #show" do
    before do
      Person.should_receive(:all).and_return([rob,roy,sam,max])   
      rob.stub!(:favourites).and_return([roy,sam])
      rob.stub!(:in_favourites).and_return([roy,sam])
      rob.favourites.stub!(:paginate).and_return([roy,sam].paginate(:page => 1, :per_page => 15))
      rob.in_favourites.stub!(:paginate).and_return([roy,sam].paginate(:page => 1, :per_page => 15))
      get :show, id: rob.id
    end
    
    it "has a 200 status code" do
      response.status.should be(200)
    end
    it "finds all people" do
      assigns(:people).should == [rob,roy,sam,max]
    end
    it "finds the right person" do
      assigns(:person).should == rob
    end
    it "finds person favourites" do
      assigns(:person_favourites).should == [roy,sam]
    end
    it "finds person's in favourites" do
      assigns(:person_in_favourites).should == [roy,sam]
    end
    it "finds people without self and favourites" do
      assigns(:people_without_self_and_favourites).should == [max]
    end
    it "creates a pagination collection" do
      assigns(:pagination_collection).should == [roy,sam]
    end
    it "renders show template" do
      response.should render_template('show') 
    end
  end
end
