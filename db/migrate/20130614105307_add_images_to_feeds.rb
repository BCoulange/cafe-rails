class AddImagesToFeeds < ActiveRecord::Migration
  def change
  	add_column :feeds, :images_url, :string
  end
end

