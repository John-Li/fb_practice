class FavouritesRelation < ActiveRecord::Base
  attr_accessible :favourites_id
  
  belongs_to :person
  belongs_to :favourites, class_name: "Person"
  belongs_to :favourite, class_name: "Person"
  
  validates :favourite, presence: true
  validates :favourites_id, presence: true, uniqueness: true
  
  def self.depending_on_fav_type(current_person_id, favourite_id, type)
    type == 'favourite' ? (favourite_id, favourites_id = current_person_id, favourite_id) : ( favourite_id, favourites_id = favourite_id, current_person_id) 
    find_by_favourite_id_and_favourites_id(favourite_id, favourites_id)
    # if type == 'favourite'
    #   find_by_favourite_id_and_favourites_id(current_person_id, favourite_id)
    # elsif type == 'in_favourite'
    #   find_by_favourite_id_and_favourites_id(favourite_id, current_person_id)
    # end
  end  
end
