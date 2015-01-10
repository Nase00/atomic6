class Comment < ActiveRecord::Base
	validates :content, :commenter_id, presence: true
	validates :title, length: { maximum: 60 }
	validates :content, length: { maximum: 750 }

  belongs_to :commenter, class_name: "User"
  belongs_to :blog, foreign_key: "blog_id"

  def html_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    markdown.render(content)
  end

  def nice_time
    if self.created_at == self.updated_at
      self.created_at.strftime("on %m/%d/%Y at %I:%M%p")
    else
      self.created_at.strftime("on %m/%d/%Y at %I:%M%p") + self.updated_at.strftime(" and edited on %m/%d/%Y at %I:%M%p")
    end
  end

  def validation_errors
    self.errors.full_messages.join(', ')
  end
end
