class AddPictureAndGenderAndLinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string
    add_column :users, :gender, :string
    add_column :users, :link, :string
  end
end
