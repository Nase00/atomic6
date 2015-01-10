class Blog < ActiveRecord::Base
	validates :title, :content, :author_id, presence: true
	validates :title, length: { maximum: 30 }
	validates :description, length: { maximum: 60 }
	validates :content, length: { maximum: 10000 }

  belongs_to :author, class_name: "User"

  has_many :comments

  def comments
  	super.order(created_at: :desc)
  end

  def html_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    markdown.render(content)
  end

  def first(number)
    if self.content.length > number
      self.html_content[0..number] + "<a id=\"continueReading\" href='/blogs/#{self.id}'>...continue reading</a>"
    else
      self.html_content
    end
  end

  def validation_errors
    self.errors.full_messages.join(', ')
  end
end
