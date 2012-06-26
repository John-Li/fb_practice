class Person < ActiveRecord::Base
  attr_accessible :name
  
  scope :for_navigation, lambda {|id, sign = '='| 
                                  if sign == '<' 
                                    where('id < ?', id).order('id desc').limit(1) 
                                  elsif sign == '>' 
                                    where('id > ?', id).limit(1) 
                                  else 
                                    where('id = ?', id).limit(1)
                                  end}
                                  
  scope :by_order, lambda {|field, order| order("#{field} #{order}") if %w{name id}.include? field and %w{asc desc}.include? order}
    
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  
  has_many :favourites_relations, foreign_key: :favourite_id, dependent: :destroy
  has_many :favourites, through: :favourites_relations, source: :favourites 
  has_many :reverse_favourites_relations, foreign_key: "favourites_id",
                                          class_name:  "FavouritesRelation",
                                          dependent:   :destroy
  has_many :in_favourites, through: :reverse_favourites_relations, source: :favourite
  
  def add_to_favourites!(favourite_id)
    favourites_relations.create(favourites_id: favourite_id)
  end
end
