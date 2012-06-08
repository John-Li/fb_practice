class Person < ActiveRecord::Base
  attr_accessible :name
  
  has_many :favourites_relations, foreign_key: :favourite_id, dependent: :destroy
  has_many :favourites, through: :favourites_relations, source: :favourites 
  has_many :reverse_favourites_relations, foreign_key: "favourites_id",
                                          class_name:  "FavouritesRelation",
                                          dependent:   :destroy
  has_many :in_favourites, through: :reverse_favourites_relations, source: :favourite
  
  def add_to_favourites!(other_person)
    favourites_relations.create!(favourites_id: other_person.id)
  end
end
