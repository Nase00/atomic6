helpers do
	def index
		@page_title.match(/All./)
	end

	def time(model)
		case model
		when User
			model.created_at.strftime("%m/%d/%Y")
		when Blog, Comment
			if model.created_at == model.updated_at
				model.created_at.strftime("on %m/%d/%Y at %I:%M%p")
			else
				model.created_at.strftime("on %m/%d/%Y at %I:%M%p") + model.updated_at.strftime(" and edited on %m/%d/%Y at %I:%M%p")
			end
		end
	end

	def current_blog
		Blog.find(params[:blog_id])
	end

	def current_comment
		Comment.find(params[:comment_id])
	end

  def latest_blogs # Queries latest 5 blog entries by admin
    Blog.where(author_id: 1).last(5).reverse
  end

	def markdown(content)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
		markdown.render(content)
	end
end
