class Article < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :published, :summary, :title, :url, :feed_id, :images_url

  belongs_to :feed


  
end


