class AddIndexToArticles < ActiveRecord::Migration
  add_index :articles, :feed_id
end
