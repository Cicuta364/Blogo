class Tag < ActiveRecord::Base

	has_many :post_tags
  	has_many :posts, through: :post_tags

  	def to_s
  	  self.name
  	end
end
