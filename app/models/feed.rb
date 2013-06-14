#encoding: utf-8
class Feed < ActiveRecord::Base
	require 'feedzirra'
  require 'sanitize'
  require 'net/http'
  require 'uri'

  	attr_accessible :name, :url, :images_url

  	has_many :articles
    has_many :images


def self.find_images_url_from_url(url)
    html = Net::HTTP.get(URI.parse(url))
  # gestion des redirections
    html =  Net::HTTP.get(URI.parse(URI.extract(html)[0])) if URI.extract(html).size == 1

    images_url = URI.extract(html).select{ |l| l[/\.(?:gif|png|jpe?g)\b/]}.select{|l| ["f","g"].include? l[-1]}

    return images_url
end

    def self.update_feed_images
      Feed.all.each do |feed|
        puts "> analyse de #{feed.name}"
        # first delete old images
        feed.images.each{|i| feed.images.destroy(i)}

        # first, find all images
        feed.articles.each_with_index do |article,i|
          images_url = find_images_url_from_url(article.url)
          if i == 0 then
            # first images
            images_url.each do |url|
              if Image.find_by_url(url).nil?
                @image = Image.new
                @image.url = url
                @image.save
              else
                @image = Image.find_by_url(url)
              end             
              feed.images << @image
            end
          else
            # cleaning
            feed.images.each{|im| feed.images.destroy(im) if !images_url.include?(im.url)}
          end 
        end
        puts "Found #{feed.images.size} images!"
      end
    end

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

              images_url = find_images_url_from_url(e.url).reject{|l| feed.images.map{|el| el.url}.include? l}


                images_url.each do |url|
                  if Image.find_by_url(url).nil?
                    @image = Image.new
                    @image.url = url
                    @image.save
                  else
                    @image = Image.find_by_url(url)
                  end  
                    @article.images << @image
                  
                end

                puts  "> #{@article.images.size} images trouvées"

              end
              @this_feed_articles << @article


              @article.save
              feed.save

        		end




      		end			

  		end	

  	end

end
