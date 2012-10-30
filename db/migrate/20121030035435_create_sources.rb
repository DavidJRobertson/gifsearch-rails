class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :base_url, null: false, unique: true
      t.datetime :last_crawled, default: nil
      t.boolean :nsfw, default: false, null: false

      t.timestamps
    end
  end
end
