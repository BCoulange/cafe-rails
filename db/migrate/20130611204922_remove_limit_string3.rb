class RemoveLimitString3 < ActiveRecord::Migration
	change_column :articles, :categories, :text, :limit => nil

end
