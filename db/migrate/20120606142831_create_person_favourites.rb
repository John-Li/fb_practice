class CreatePersonFavourites < ActiveRecord::Migration
  def change
    create_table :person_favourites do |t|
      t.integer :person_id
      t.integer :favourites_id

      t.timestamps
    end
    
    add_index :person_favourites, :person_id
    add_index :person_favourites, :favourites_id
    add_index :person_favourites, [:person_id, :favourites_id], unique: true
  end
end
