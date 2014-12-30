class Comment < ActiveRecord::Base
	validates :title, :content, :commenter_id, presence: true
	validates :title, length: { maximum: 30 }
	validates :content, length: { maximum: 10000 }

  belongs_to :commenter, class_name: "User"
  belongs_to :blog, foreign_key: "commenter_id"
end
