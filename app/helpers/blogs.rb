helpers do
	def privilaged # Determines element visibility based on user status
		if logged_in?
			authored_blog || logged_in_user.is_admin
		else
			false
		end
	end

	def current_blog
		Blog.find(params[:id])
	end

  def authored_blog # Validates if the user created the blog they are viewing
  	current_blog.author.id == logged_in_user.id if params[:id]
	end

  def latest_blogs # Queries latest 5 blog entries by admin
    Blog.where(author_id: 1).last(5).reverse
  end

	def markdown(content)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
		markdown.render(content)
	end
end
