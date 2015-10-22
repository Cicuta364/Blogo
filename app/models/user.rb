class User < ActiveRecord::Base

	before_save	:default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :post_likes, through: :likes, source: :post
  has_many :comment_likes, through: :likes, source: :comment

  validates :username, uniqueness: { case_sensitive: false }
  validate :validate_username

  enum role: [:admin, :editor, :user, :guest]

  def default_role
  	self.role ||= 2

  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def to_s
    "#{self.name} #{self.last_name}"
  end
end
