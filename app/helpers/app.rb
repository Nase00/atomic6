helpers do
	def blogs
		Blog.all.reverse
	end

	def time(model)
		if model.created_at == model.updated_at
			model.created_at.strftime("on %m/%d/%Y at %I:%M%p")
		else
			model.created_at.strftime("on %m/%d/%Y at %I:%M%p") + model.updated_at.strftime(" and edited on %m/%d/%Y at %I:%M%p")
		end
	end

	# def updated(model)
	# 	if model.created_at == model.updated_at
	# 		false
	# 	else
	# 		model.updated_at.strftime("on %m/%d/%Y at %I:%M%p")
	# 	end
	# end

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
