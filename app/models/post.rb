class Post < ActiveRecord::Base
	as_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :content, presence: true
end
