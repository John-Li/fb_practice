class SessionsController < ApplicationController
  include SessionsHelper
  
  def create
    attributes = parse_omniauth(env["omniauth.auth"])
    user = User.find_or_create_by_uid(attributes[:uid], attributes)
    session[:user_id] = user.id
    redirect_to user_path user
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end