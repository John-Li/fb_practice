class Person < ActiveRecord::Base
  attr_accessible :name
  
  has_many :person_favourites, foreign_key: "person_id", class_name: "PersonFavourites", dependent: :destroy
  has_many :favourites, through: :person_favourites, source: "favourites_id"
  has_many :in_favourites, through: :person_favourites, source: "person_id"
  
  def add_to_favourites!(other_person)
    person_favourites.create!(favourites_id: other_person.id)
  end
end
