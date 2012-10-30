class FixIndexedGifIndices < ActiveRecord::Migration
  def change
    remove_index :indexed_gifs, :source_url
    remove_index :indexed_gifs, :source_id
  end
end
