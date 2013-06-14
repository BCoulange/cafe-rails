#encoding: utf-8
class Feed < ActiveRecord::Base
	require 'feedzirra'
  require 'sanitize'
  require 'net/http'
  require 'uri'

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
        			@article.summary = Sanitize.clean(e.summary, :remove_contents => ['script', 'style'])
         			@article.title = Sanitize.clean(e.title, :remove_contents => ['script', 'style'])
         			@article.url = e.url
              @article.feed_id = feed.id
              unless e.url.nil?
                html = Net::HTTP.get(URI.parse(e.url))

                # gestion des redirections
                html =  Net::HTTP.get(URI.parse(URI.extract(html)[0])) if URI.extract(html).size == 1

                @article.images_url = URI.extract(html).select{ |l| l[/\.(?:gif|png|jpe?g)\b/]}.select{|l| ["f","g"].include? l[-1]}
                puts  "> #{@article.images_url.size} images trouvées"
                puts @article.images_url.inspect
              end
              @this_feed_articles << @article


              @article.save

        		end

            # clean image array
            

      		end			

  		end	

  	end

end
