class User < ActiveRecord::Base
  validates :name, :email, :hashed_password, presence: true
  
  has_many :blogs, foreign_key: "author_id"
  has_many :comments, through: :blogs

  has_many :galleries, foreign_key: "creator_id"
  has_many :projects, through: :galleries

  def password=(password)
    self.hashed_password = BCrypt::Password.create(password) if password.length > 6
  end

  def password
    BCrypt::Password.new(self.hashed_password)
	end

  def authenticate(password)
    self.password == password
  end
end
