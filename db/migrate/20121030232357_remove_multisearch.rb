class RemoveMultisearch < ActiveRecord::Migration
  def up
    drop_table :pg_search_documents
  end
end
