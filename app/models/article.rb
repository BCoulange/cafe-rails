class Article < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :published, :summary, :title, :url
end
