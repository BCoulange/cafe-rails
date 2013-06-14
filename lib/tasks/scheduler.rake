desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  Feed.update
  puts "done."
end


task :update_articles => :environment do 
  puts "Updating articles..."
  Article.refresh_images
  puts "done."
end