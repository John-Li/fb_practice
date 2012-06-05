class PersonsController < ApplicationController

  def index
  end
  
  def show
    @person = Person.where("id > ?", params[:id]).first
    respond_to do |format|
      format.html 
      format.json do 
        render :json => @person.to_json
      end
    end
  end
end

