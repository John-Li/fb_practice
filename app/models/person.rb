class Person < ActiveRecord::Base
  attr_accessible :name
  
  scope :by_order, lambda {|field, order| order("#{field} #{order}") if %w{name id}.include? field and %w{asc desc}.include? order}
  
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  
  has_many :favourites_relations, foreign_key: :favourite_id, dependent: :destroy
  has_many :favourites, through: :favourites_relations, source: :favourites 
  has_many :reverse_favourites_relations, foreign_key: "favourites_id",
                                          class_name:  "FavouritesRelation",
                                          dependent:   :destroy
  has_many :in_favourites, through: :reverse_favourites_relations, source: :favourite
  
  def add_to_favourites!(other_person)
    favourites_relations.create(favourites_id: other_person.id)
  end
  
  def delete_from_favourites!(other_person)
    favourites_relations.find_by_favourites_id(other_person.id).destroy
  end
  
  def has_in_favourites?(other_user)
    favourites.include?(other_user)
  end
end
