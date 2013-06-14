class Image < ActiveRecord::Base
  attr_accessible :url

  belongs_to :feed
  belongs_to :article
end
