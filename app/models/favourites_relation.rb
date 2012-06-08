class FavouritesRelation < ActiveRecord::Base
  attr_accessible :favourites_id, :favourite_id
  
  belongs_to :person
  belongs_to :favourites, class_name: "Person"
  belongs_to :favourite, class_name: "Person"
end
