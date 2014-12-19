class User < ActiveRecord::Base
  has_many :blogs
  has_many :posts, through: :blogs

  has_many :galleries
  has_many :projects, through: :galleries
end
