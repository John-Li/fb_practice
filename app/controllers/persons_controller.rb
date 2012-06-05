class PersonsController < ApplicationController

  def add_person
  end
  
  def get_person
    @person = Person.one_at_a_time
    respond_to do |format|
      format.html 
      format.json do 
        render :json => @person.to_json
      end
    end
  end
end
