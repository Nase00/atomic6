helpers do
	def current_blog
		Blog.find(params[:id])
	end

  def authored_blog # Validates if the user created the blog they are viewing
  	current_blog.author.id == logged_in_user.id
	end

  def latest_blogs # Queries last 5 blog entries
    Blog.last(5)
  end

  # def latest_blogs # Queries last 5 blog entries by first admin
  #   Blog.where
  # end
end
