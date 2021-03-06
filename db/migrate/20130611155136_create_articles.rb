class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.string :author
      t.string :summary
      t.string :content
      t.time :published
      t.string :categories

      t.timestamps
    end
  end
end
