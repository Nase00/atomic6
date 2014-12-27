class User < ActiveRecord::Base
  has_many :blogs, foreign_key: "author_id"
  has_many :posts, through: :blogs

  has_many :galleries, foreign_key: "creator_id"
  has_many :projects, through: :galleries

	validates :name, :email, :hashed_password, presence: true

  def password=(password)
    self.hashed_password = BCrypt::Password.create(password)
  end

  def password
    BCrypt::Password.new(self.hashed_password)
	end

  def authenticate(password)
    self.password == password
  end
end
