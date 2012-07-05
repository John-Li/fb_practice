module UsersHelper
  def picture_of(fb_user_id)
    @user.facebook.get_picture(fb_user_id)
  end
end