class CreateFavouritesRelations < ActiveRecord::Migration
  def change
    create_table :favourites_relations do |t|
      t.integer :favourite_id
      t.integer :favourites_id

      t.timestamps
    end
    
    add_index :favourites_relations, :favourite_id
    add_index :favourites_relations, :favourites_id
    add_index :favourites_relations, [:favourite_id, :favourites_id], unique: true
  end
end
