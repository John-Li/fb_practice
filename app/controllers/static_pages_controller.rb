class StaticPagesController < ApplicationController
  def login
    redirect_to user_path current_user if current_user
  end
end