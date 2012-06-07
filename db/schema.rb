# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120606142831) do

  create_table "images", :force => true do |t|
    t.string   "file_name"
    t.string   "content_type"
    t.integer  "file_size"
    t.string   "file"
    t.integer  "promotion_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_favourites", :force => true do |t|
    t.integer  "person_id"
    t.integer  "favourites_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "person_favourites", ["favourites_id"], :name => "index_person_favourites_on_favourites_id"
  add_index "person_favourites", ["person_id", "favourites_id"], :name => "index_person_favourites_on_person_id_and_favourites_id", :unique => true
  add_index "person_favourites", ["person_id"], :name => "index_person_favourites_on_person_id"

  create_table "promotion_cards", :force => true do |t|
    t.string   "card_number"
    t.integer  "promotion_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "promotions", :force => true do |t|
    t.string "company_name"
    t.string "title"
    t.text   "desc"
    t.time   "start_time"
    t.time   "end_time"
    t.string "logo"
  end

end
