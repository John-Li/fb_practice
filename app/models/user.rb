class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :gender, :link, :picture
  
  has_many :friends_relations, dependent: :destroy
  has_many :friends, through: :friends_relations, source: :friend
  has_many :reverse_friends_relations, foreign_key: "friend_id",
                                       class_name:  "FriendsRelation",
                                       dependent:   :destroy
  has_many :in_friends, through: :reverse_friends_relations, source: :user
  
  def self.from_omniauth(auth)
    init_hash = { provider: auth.provider,
                  uid: auth.uid,
                  name: auth.info.name,
                  gender: auth.extra.raw_info.gender,
                  link: auth.extra.raw_info.link,
                  picture: auth.info.image,
                  oauth_token: auth.credentials.token,
                  oauth_expires_at: Time.at(auth.credentials.expires_at) }
    user = find_or_initialize_by_uid(auth.uid, init_hash)
    user.save! if user.new_record?
    user
  end
  
  def add_to_friends(user_id)
    friends_relations.create(friend_id: user_id)
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
  
  def friends_info
    friends_ids = []
    friends = facebook.get_connection("me","friends")
    friends.each {|friend| friends_ids << friend['id']}
    friends_full_info, friends_pictures = facebook.batch do |batch_api|
                                            batch_api.get_objects(friends_ids)
                                            batch_api.get_objects(friends_ids,{"fields"=>"picture"})
                                          end
    friends_full_info.merge(friends_pictures){|key,friend,pic| friend.merge(pic)}    
  end

  def initialize_friends
    friends_info.each do | friend_uid, friend_info |
      friend_info_hash = { uid: friend_info['id'],
                           name: friend_info['name'],
                           picture: friend_info['picture'],
                           gender: friend_info['gender'],
                           link: friend_info['link'] }
      friend = User.find_or_initialize_by_uid(friend_uid, friend_info_hash)
      if friend.new_record?
        friend.save
        add_to_friends(friend.id)
      else
        friend.update_attributes(friend_info_hash)
      end
    end
  end
  
end