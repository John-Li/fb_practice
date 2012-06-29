class UsersController < ApplicationController
  def show
    @user = current_user
    @friends = @user.friends.paginate(:page => params[:page], :per_page => 15)
  end
end