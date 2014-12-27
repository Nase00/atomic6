class Project < ActiveRecord::Base
	validates :title, :content, :creator_id, presence: true

  belongs_to :creator, class_name: "User"
  belongs_to :gallery
end
