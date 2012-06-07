class PersonFavourites < ActiveRecord::Base
  attr_accessible :favourites_id, :person_id
  
  belongs_to :person
  belongs_to :favourites, class_name: "Person"
  belongs_to :in_favourites, class_name: "Person"
end
