class Person < ActiveRecord::Base
  attr_accessible :name
 
  last_selected =+ 1
 
  scope :one_at_a_time, lambda {
                          where("id ?", last_selected)
                          last_selected =+ 1
                        }
end
