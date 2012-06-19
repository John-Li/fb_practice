class FavouritesRelationsController < ApplicationController
respond_to :json, :html
 
  def create
    @current_person = Person.find(params[:current_person_id])
    favourite = Person.find(params[:favourite_id])
    @current_person.add_to_favourites!(favourite)
    @current_person.errors.empty? ? (flash[:notice] = "Successfully added #{favourite.name} to favourites") : (flash[:error] = @current_person.errors.full_messages)
    
    respond_with favourite
  end
  
  def destroy
    record = FavouritesRelation.depending_on_fav_type(params[:current_person_id], params[:favourite_id], params[:type])
    record.destroy

    if params[:type] == 'favourite'
      flash[:notice] = "Successfully deleted from favourites"
    elsif params[:type] == 'in_favourite'
      flash[:notice] = "Successfully deleted self from favourites"
    end
    
    respond_with record
  end
end