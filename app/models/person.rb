class Person < ActiveRecord::Base
  attr_accessible :name
  
  has_many :person_favourites, class_name: "PersonFavourites", dependent: :destroy
  has_many :favourites, through: :person_favourites, foreign_key: :favourites_id
  has_many :in_favourites, through: :person_favourites # DOTO reflect this in the correct association: SELECT `people`.* FROM `people` INNER JOIN `person_favourites` ON `people`.`id` = `person_favourites`.`favourites_id` WHERE `person_favourites`.`person_id` = 210;
  
  def add_to_favourites!(other_person)
    person_favourites.create!(favourites_id: other_person.id)
  end
end
