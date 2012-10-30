class AddTsvIndex < ActiveRecord::Migration
  def up
    execute %Q( CREATE INDEX gifs_fts_idx
                ON indexed_gifs
                USING gin( ("indexed_gifs"."tsv") );
              )
  end

  def down
    execute "DROP INDEX gifs_fts_idx;"
  end
end
