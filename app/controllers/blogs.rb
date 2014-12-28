get '/blogs' do
  @blogs = blogs
  erb :'blogs/index'
end

get '/blogs/new' do
  @error = params.keys.first.sub(/Validation failed: /, '') if @error
	erb :'blogs/new'
end

post '/blogs' do
	@blog = Blog.new(title: params[:title], description: params[:description], content: params[:content], author_id: logged_in_user.id)
	if catch_errors(@blog) == true
		redirect :"/blogs/#{@blog.id}"
	else
		redirect :"/blogs/new?#{catch_errors(@blog)}"
	end
end

delete '/blogs/all' do # Probably not RESTful, come back to this
	Blog.destroy(params[:selected_blog].keys)
	redirect :'blogs'
end

delete '/blogs/:blog_id' do
	Blog.destroy(params[:blog_id])
	Comment.destroy_all(blog_id: params[:blog_id])
	redirect :'/blogs'
end

get '/blogs/:blog_id' do
  erb :'blogs/show'
end

get '/blogs/:blog_id/edit' do
	erb :'blogs/edit'
end

put '/blogs/:blog_id' do
  current_blog.update(title: params[:title], description: params[:description], content: params[:content])
  redirect :"/blogs/#{current_blog.id}"
end