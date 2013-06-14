class AddImagesToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :images_url, :string
  end
end

