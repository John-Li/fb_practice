class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file_name
      t.string :content_type
      t.integer :file_size
      t.string :file
      t.integer :promotion_id

      t.timestamps
    end
  end
end
