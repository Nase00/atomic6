class Blog < ActiveRecord::Base
  belongs_to :user, class_name: "User"

  has_many :posts
end
