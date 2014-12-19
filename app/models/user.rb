class User < ActiveRecord::Base
  has_many :blogs, foreign_key: "author_id"
  has_many :posts, through: :blogs

  has_many :galleries, foreign_key: "creator_id"
  has_many :projects, through: :galleries
end
