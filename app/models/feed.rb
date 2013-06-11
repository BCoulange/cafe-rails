#encoding: utf-8
class Feed < ActiveRecord::Base
	require 'feedzirra'

  	attr_accessible :name, :url

  	has_many :articles


  	def self.update
  		Feed.all.each do |feed|
 
          # destroy old articles
            feed.articles.each do |article|
              article.destroy
            end 



          # get feed
          puts "[Feed.update] updating #{feed.name}..."
        	fzir = Feedzirra::Feed.fetch_and_parse(feed.url)
 


          # get new articles
          @this_feed_articles = []
      		unless fzir.is_a?(Fixnum) || fzir.nil?
            puts "> #{fzir.entries.size} entrées trouvées"
        		fzir.entries.each do |e|
        			@article = Article.new
        			@article.author = e.author       			
        			@article.categories = e.categories
        			@article.content = e.content
        			@article.published = e.published.to_datetime
        			@article.summary = e.summary
        			@article.title = e.title
        			@article.url = e.url
              @article.feed_id = feed.id
              @this_feed_articles << @article

              puts "@article.author.size #{@article.author.size}" unless @article.author.size.nil?           
              puts "@article.categories.size #{@article.categories.size}" unless @article.categories.size.nil?
              puts "@article.content.size #{@article.content.size}" unless @article.content.size.nil?
              puts "@article.published.size #{@article.published.size}" unless @article.published.size.nil?
              puts "@article.summary.size #{@article.summary.size}" unless @article.summary.size.nil?
              puts "@article.title.size #{@article.title.size}" unless @article.title.size.nil?
              puts "@article.url.size #{@article.url.size}" unless @article.url.size.nil?
              puts "@article.feed_id.size #{@article.feed_id.size}" unless @article.feed_id.size.nil?

              @article.save

        		end


      		end			

  		end	

  	end

end
