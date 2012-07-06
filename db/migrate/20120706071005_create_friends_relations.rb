class CreateFriendsRelations < ActiveRecord::Migration
  def change
    create_table :friends_relations do |t|
      t.integer :user_id
      t.integer :friend_id
      
      t.timestamps
    end
    
    add_index :friends_relations, :user_id
    add_index :friends_relations, :friend_id
    add_index :friends_relations, [:user_id, :friend_id], unique: true
  end
end
