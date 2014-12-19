class Blog < ActiveRecord::Base
  belongs_to :user, foreign_key: "author_id"

  has_many :posts
end
