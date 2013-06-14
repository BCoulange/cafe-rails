class RemoveImage < ActiveRecord::Migration
  def change
  	remove_column :articles, :images_url
  	remove_column :feeds, :images_url


  	remove_column :images, :feed_id
  	remove_column :images, :article_id


  	create_table :feeds_images, :id => false do |t|
      t.integer :feed_id
      t.integer :image_id
    end

  	create_table :articles_images, :id => false do |t|
      t.integer :article_id
      t.integer :image_id
    end


  end
end
