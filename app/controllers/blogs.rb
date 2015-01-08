get '/blogs' do
	@page_title = "All blogs"
  @blogs = Blog.all.order(created_at: :desc)
  erb :'blogs/index'
end

get '/blogs/new' do
	@blog = Hash.new # Prevents ugly nil error
	erb :'blogs/new'
end

post '/blogs' do
	@blog = Blog.new(params[:newBlog])
	if @blog.save
		redirect :"/blogs/#{blog.id}"
	else
		@error_message = @blog.errors.full_messages.join(', ')
		erb :"/blogs/new"
	end
end

delete '/blogs/all' do # Probably not RESTful, come back to this
	Blog.destroy(params[:selected_blog].keys)
	Comment.destroy_all(blog_id: params[:selected_blog].keys)
	redirect :'blogs'
end

delete '/blogs/:blog_id' do
	Blog.destroy(params[:blog_id])
	Comment.destroy_all(blog_id: params[:blog_id])
	redirect :'/blogs'
end

get '/blogs/:blog_id' do
	@comments = current_blog.comments
  erb :'blogs/show'
end

get '/blogs/:blog_id/edit' do
	@blog = Hash.new
	erb :'blogs/edit'
end

put '/blogs/:blog_id' do
  if catch_errors(current_blog, params[:editBlog], "update") === true
	  redirect :"/blogs/#{current_blog.id}"
	else
		@blog = params[:editBlog]
		@error_message = catch_errors(current_blog, params[:editBlog], "update")
		erb :"/blogs/edit"
	end
end

get '/blogs/by_user/:user_id' do
	@page_title = "Blogs by " + User.find(params[:user_id]).name
  @blogs = Blog.where(author_id: params[:user_id]).reverse
  erb :'blogs/index'
end
