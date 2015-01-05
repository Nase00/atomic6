class Blog < ActiveRecord::Base
	validates :title, :content, :author_id, presence: true
	validates :title, length: { maximum: 30 }
	validates :description, length: { maximum: 60 }
	validates :content, length: { maximum: 10000 }

  belongs_to :author, class_name: "User"

  has_many :comments

  def first(number)
  	if self.content.length > number
	  	self.content[0..number] + "<a id=\"continueReading\" href='/blogs/#{self.id}'>...continue reading</a>"
	  else
	  	self.content
	  end
  end

  def comments
  	super.reverse
  end
end
