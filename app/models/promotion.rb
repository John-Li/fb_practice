class Promotion < ActiveRecord::Base
  attr_accessible :desc, :end_time, :start_time, :title, :company_name
  has_many :images
end
