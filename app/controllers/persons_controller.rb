class PersonsController < ApplicationController
  include PersonsHelper
  respond_to :json, :html

  def index
    @letters_for_select = ""
    ('A'..'Z').each {|letter| @letters_for_select << "<option>#{letter}</option>"}

    @people = if ('A'..'Z').include? params[:first_letter]
                Person.where("name like ?", "params[:first_letter]%").paginate(:page => params[:page], :per_page => 15)
              else
                Person.by_order(params[:field], params[:order]).paginate(:page => params[:page], :per_page => 15)
              end
      
    respond_with @people  
  end
  
  def show
    people = Person.all
    favourite = Person.find(params[:id])
    @person = people.delete(favourite)
    @previous_person = previous_person(people, @person)
    @next_person = next_person(people, @person)
    @person_favourites = @person.favourites.paginate(:page => params[:page], :per_page => 15)
    @person_in_favourites = @person.in_favourites.paginate(:page => params[:page], :per_page => 15)
    @people_without_self = people
    @pagination_collection = @person_in_favourites.size > @person_favourites.size ? @person_in_favourites : @person_favourites
    
    respond_with @person
  end
end