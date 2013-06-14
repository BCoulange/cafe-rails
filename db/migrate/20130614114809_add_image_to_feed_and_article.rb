class AddImageToFeedAndArticle < ActiveRecord::Migration
  def change
    add_column :images, :feed_id, :integer
    add_index :images, :feed_id
    add_column :images, :article_id, :integer
    add_index :images, :article_id
  end
end
