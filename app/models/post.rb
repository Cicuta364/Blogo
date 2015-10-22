class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

	has_many :post_tags, dependent: :destroy
	has_many :tags, through: :post_tags

	has_many :likes, as: :likeable
	has_many :user_likes, through: :likes, source: :user

	validates :title, presence: true
	validates :content, presence: true

	#default_scope {order(realease_date: :desc)}

	def remove_like (user)
		self.likes.where(user: user).first.delete

	end

	def liked_by? (user)
		self.user_likes.include? user
	end
end
