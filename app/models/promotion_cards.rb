class PromotionCards < ActiveRecord::Base
  attr_accessible :card_number, :promotion_id
  belongs_to :promotion
end
