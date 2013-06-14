class Image < ActiveRecord::Base
  attr_accessible :url

  has_and_belongs_to_many :feeds
  has_and_belongs_to_many :articles


end
