class Post < ActiveRecord::Base
	validates :title, :content, :poster_id, presence: true

  belongs_to :poster, class_name: "User"
  belongs_to :blog
end
