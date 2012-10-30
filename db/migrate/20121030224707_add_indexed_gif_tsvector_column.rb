class AddIndexedGifTsvectorColumn < ActiveRecord::Migration
  def up
    execute %Q( ALTER TABLE indexed_gifs
                ADD COLUMN tsv tsvector;

                CREATE TRIGGER tsvectorupdate
                BEFORE INSERT OR UPDATE ON indexed_gifs
                FOR EACH ROW EXECUTE PROCEDURE
                tsvector_update_trigger(tsv, 'pg_catalog.english', tags, caption, individual_caption); )

  end

  def down
    execute %Q(
                ALTER TABLE indexed_gifs
                DROP COLUMN tsv;
              )
  end
end
