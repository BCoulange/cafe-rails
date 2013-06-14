desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  Feed.update
  puts "done."
end


task :update_feed_images => :environment do 
  puts "Finding images..."
  Feed.update_feed_images
  puts "done."
end