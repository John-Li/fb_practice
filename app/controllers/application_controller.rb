class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :flash_to_headers
  
  def flash_to_headers
    return unless request.xhr?
    [:warning, :error, :notice].each do |type|
      unless flash[type].blank?
        response.headers['X-Message'] = flash[type]
        response.headers['X-Message-Type'] = type.to_s
      end
    end
    # repeat for other flash types...

    flash.discard  # don't want the flash to appear when you reload page
  end
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
