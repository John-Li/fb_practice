class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :company_name
      t.string :title
      t.text :desc
      t.time :start_time
      t.time :end_time
    end
  end
end
