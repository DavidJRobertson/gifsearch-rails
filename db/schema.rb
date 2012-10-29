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

ActiveRecord::Schema.define(:version => 20121029202137) do

  create_table "indexed_gifs", :force => true do |t|
    t.string   "url",                                                :null => false
    t.string   "source_url"
    t.string   "source_name"
    t.integer  "source_id",          :limit => 8
    t.text     "caption"
    t.text     "individual_caption"
    t.text     "tags"
    t.boolean  "nsfw",                            :default => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "indexed_gifs", ["source_id"], :name => "index_indexed_gifs_on_source_id", :unique => true
  add_index "indexed_gifs", ["source_url"], :name => "index_indexed_gifs_on_source_url", :unique => true
  add_index "indexed_gifs", ["url"], :name => "index_indexed_gifs_on_url", :unique => true

end
