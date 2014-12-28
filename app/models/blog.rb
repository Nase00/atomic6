class Blog < ActiveRecord::Base
	validates :title, :content, :author_id, presence: true

  belongs_to :author, class_name: "User"

  has_many :comments

  def first(number)
  	self.content[0..number] + "..."
  end
end
