class CreatePromotionCards < ActiveRecord::Migration
  def change
    create_table :promotion_cards do |t|
      t.string :card_number
      t.integer :promotion_id

      t.timestamps
    end
  end
end
