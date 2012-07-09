class SearchController < ApplicationController
  
  respond_to :json
  
  def search
    user = User.find(params[:user_id])
    friends = params[:query] && params[:query].present? ? 
              user.friends.where(
                'name LIKE ? or gender LIKE ?', "%#{params[:query]}%", "#{params[:query]}%"
              ).order(:name) : user.friends
    
    respond_with(friends)
  end
end
