class Promotion < ActiveRecord::Base
  attr_accessible :desc, :end_time, :start_time, :title, :company_name, :logo
  mount_uploader :logo, LogoUploader
  has_many :images
end
