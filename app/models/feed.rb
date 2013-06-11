class Feed < ActiveRecord::Base
	require 'feedzirra'

  	attr_accessible :name, :url

  	has_many :articles


  	def self.update
  		Feed.all.each do |feed|
          # get feed
          puts "[Feed.update] updating #{feed.name}..."
        	fzir = Feedzirra::Feed.fetch_and_parse(feed.url)
        	
          # get new articles
          @this_feed_articles = []
      		unless fzir.is_a?(Fixnum) || fzir.nil?
        		fzir.entries.each do |e|
        			@article = Article.new
        			@article.author = e.author       			
        			@article.categories = e.categories
        			@article.content = e.content
        			@article.published = e.published
        			@article.summary = e.summary
        			@article.title = e.title
        			@article.url = e.url
              @this_feed_articles << @article
              @article.save
        		end
            # update feed
            @old_articles = feed.articles
            feed.articles = @this_feed_articles
            feed.save

            # destroy old articles
            @old_articles.each do |article|
              article.destroy
            end 

      		end			

  		end	

  	end

end
