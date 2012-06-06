class PersonsController < ApplicationController
  respond_to :json, :html

  def index
    @people = if %w{name id}.include? params[:field] and %w{asc desc}.include? params[:order]
                Person.order("#{params[:field]} #{params[:order]}") 
              else
                Person.all
              end
    
    respond_with @people  
  end
  
  def show
    #TODO add order id ASC
    @person = Person.where("id > ?", params[:id]).first
    
    respond_with @person
  end
end

