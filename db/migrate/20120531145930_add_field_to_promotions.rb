class AddFieldToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :logo, :string
  end
end
