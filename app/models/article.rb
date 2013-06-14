class Article < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :published, :summary, :title, :url, :feed_id

  has_and_belongs_to_many :images

  belongs_to :feed


  def self.refresh_images
  	Article.all.each do |a|
  		puts "> cas de #{a.title}"
  		@feed = Feed.find(a.feed_id)

  		a.images.each do |image|
	  		a.images.delete(image) if @feed.images.map{|el| el.url}.include? image.url
	  	end
  	end
  end
  
end


