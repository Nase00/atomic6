class Comment < ActiveRecord::Base
	validates :title, :content, :commenter_id, presence: true

  belongs_to :commenter, class_name: "User"
  belongs_to :blog
end
