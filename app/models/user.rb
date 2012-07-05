class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :gender, :link, :picture
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.gender = auth.extra.raw_info.gender
      user.link = auth.extra.raw_info.link
      user.picture = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
  
  # def friends
  #   facebook {|fb| fb.get_connection("me","friends")}
  # end
  # def initialize_friends
  #   friends = facebook { |fb| fb.get_connections("me", "friends") }
  #   friends_for_select = []
  #   friends.each do |friend|
  #     friends_for_select << User.where(uid: friend['id']).first_or_initialize.tap do |user|
  #       user.uid = friend['id']
  #       user.name = friend['name']
  #       user.gender = friend['gender']
  #       user.link = friend['link']
  #       user.picture = facebook.get_picture(friend['id'])
  #       user.save!
  #     end
  #   end
  #   friends_for_select
  # end
  
  def friends
    friends_ids = []
    friends = facebook.get_connection("me","friends")
    friends.each {|friend| friends_ids << friend['id']}
    friends_full_info, friends_pictures = facebook.batch do |batch_api|
                                            batch_api.get_objects(friends_ids)
                                            batch_api.get_objects(friends_ids,{"fields"=>"picture"})
                                          end
    friends_full_info.merge(friends_pictures){|key,friend,pic| friend.merge(pic)}    
  end
end
