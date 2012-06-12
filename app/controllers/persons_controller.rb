class PersonsController < ApplicationController
  respond_to :json, :html

  def index
    @people = Person.by_order(params[:field], params[:order])
      
    respond_with @people  
  end
  
  def show
    #TODO add order id ASC
    @person = Person.where("id > ?", params[:id]).first
    
    respond_with @person
  end
end

