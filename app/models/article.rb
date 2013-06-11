class Article < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :published, :summary, :title, :url, :feed_id

  belongs_to :feed


  
end


