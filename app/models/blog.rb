class Blog < ActiveRecord::Base
	validates :title, :content, :author_id, presence: true

  belongs_to :author, class_name: "User"

  has_many :comments

  def first(number)
  	if self.content.length > number
	  	self.content[0..number] + "<a id=\"continueReading\" href='/blogs/#{self.id}'>...continue reading</a>"
	  else
	  	self.content
	  end
  end
end
