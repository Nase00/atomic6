helpers do
	def index
		@page_title.match(/All./)
	end

	def current_blog
		Blog.find(params[:blog_id])
	end

	def current_comment
		Comment.find(params[:comment_id])
	end

  def latest_blogs # latest 5 blog entries by site owner
    Blog.where(author_id: 1).last(5).reverse
  end

  def comments_exist
  	current_blog.comments.length != 0
  end
end
