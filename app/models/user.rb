class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :gender, :link, :picture
  
  has_many :friends_relations, dependent: :destroy
  has_many :friends, through: :friends_relations, source: :friend
  has_many :reverse_friends_relations, foreign_key: "friend_id",
                                       class_name:  "FriendsRelation",
                                       dependent:   :destroy
  has_many :in_friends, through: :reverse_friends_relations, source: :user
  
  validate :uid, :uniqueness => {:message => 'Such user already exist'}
  after_create :initialize_friends, :if => proc {|user| !user.oauth_token.nil?}
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
  
  def friends_info
    friends = facebook.get_connection("me","friends")
    friends_ids = friends.inject([]) {|base, hash| base << hash['id']; base}
    friends_full_info, friends_pictures = facebook.batch do |batch_api|
                                            batch_api.get_objects(friends_ids)
                                            batch_api.get_objects(friends_ids,{"fields"=>"picture"})
                                          end
    friends_full_info.merge(friends_pictures) {|key,friend,pic| friend.merge(pic)}    
  end

  def initialize_friends
    friends_info.each do | friend_uid, friend_info |
      friend_info_hash = { uid: friend_info['id'] }
      friend_info.inject(friend_info_hash) {|base, attr| base[attr.first] = attr.last if %w(name picture gender link).include? attr.first; base}
      friend = User.find_or_initialize_by_uid(friend_uid, friend_info_hash)
      if friend.new_record?
        friend.save
        friends_relations.create(friend_id: friend.id)
      else
        friend.update_attributes(friend_info_hash)
      end
    end
  end
  
end