class CreateIndexedGifs < ActiveRecord::Migration
  def change
    create_table :indexed_gifs do |t|
      t.string :url, null: false
      t.string :source_url
      t.string :source_name
      t.integer :source_id, limit: 8
      t.text :caption
      t.text :individual_caption
      t.text :tags
      t.boolean :nsfw, default: false

      t.timestamps
    end
    add_index :indexed_gifs, :url, unique: true
    add_index :indexed_gifs, :source_url, unique: true
    add_index :indexed_gifs, :source_id, unique: true
  end
end
