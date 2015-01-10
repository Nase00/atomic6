class User < ActiveRecord::Base
  validates :name, :email, :hashed_password, presence: true
  validates :password, length: { minimum: 8 }
  
  has_many :blogs, foreign_key: "author_id"
  has_many :comments, through: :blogs

  has_many :galleries, foreign_key: "creator_id"
  has_many :projects, through: :galleries

  # has_secure_password

  def nice_time
    self.created_at.strftime("%m/%d/%Y")
  end

  def password=(password)
    # raise 'Password too short (minimum 6 characters)' if password.length > 6
    self.hashed_password = BCrypt::Password.create(password)
  end

  def password
    BCrypt::Password.new(self.hashed_password)
  end

  def authenticate(password)
    self.password == password
  end
end
