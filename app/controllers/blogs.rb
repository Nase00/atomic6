get '/blogs' do
	@page_title = "All blogs"
  @blogs = Blog.all.order(created_at: :desc)
  erb :'blogs/index'
end

get '/blogs/new' do
	@blog = Blog.new # Prevents ugly nil error
	erb :'blogs/new'
end

post '/blogs' do
	@blog = Blog.new(params[:newBlog])
	if @blog.save
		redirect :"/blogs/#{blog.id}"
	else
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

get '/blogs/search' do
	erb :'blogs/search'
end

get '/blogs/:blog_id' do
	@comments = current_blog.comments
  erb :'blogs/show'
end

get '/blogs/:blog_id/edit' do
	@blog = Blog.new
	erb :'blogs/edit'
end

put '/blogs/:blog_id' do
	@blog = current_blog
  if @blog.update(params[:editBlog])
	  redirect :"/blogs/#{current_blog.id}"
	else
		erb :"/blogs/edit"
	end
end

get '/blogs/by_user/:user_id' do
	@page_title = "Blogs by " + User.find(params[:user_id]).name
  @blogs = Blog.where(author_id: params[:user_id]).reverse
  erb :'blogs/index'
end
