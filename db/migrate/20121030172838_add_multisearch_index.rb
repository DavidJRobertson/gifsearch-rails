class AddMultisearchIndex < ActiveRecord::Migration
  def up
    execute %Q(
      CREATE INDEX multisearch_idx
      ON pg_search_documents
      USING gin( (to_tsvector('simple', coalesce("pg_search_documents"."content"::text, ''))) );
    )
  end

  def down
    execute "DROP INDEX multisearch_idx;"
  end
end
