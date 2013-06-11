class RemoveLimitString2 < ActiveRecord::Migration


	change_column :articles, :author, :text, :limit => nil

end
