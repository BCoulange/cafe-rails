class RemoveLimitString < ActiveRecord::Migration
	change_column :articles, :content, :text, :limit => nil
	change_column :articles, :summary, :text, :limit => nil
	change_column :articles, :url, :text, :limit => nil
	change_column :articles, :title, :text, :limit => nil	
	change_column :feeds, :url, :text, :limit => nil	

end
