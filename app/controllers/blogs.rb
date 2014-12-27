get '/blogs' do
  @blogs = Blog.all
  erb :'blogs/index'
end

get '/blogs/new' do
	@all_blank = params["all_blank"] == "true"
  @title_blank = params["title_blank"] == "true"
  @content_blank = params["content_blank"] == "true"
	erb :'blogs/new'
end

post '/blogs' do
	@blog = Blog.new(title: params[:title], description: params[:description], content: params[:content], author_id: logged_in_user.id)
	if catch_errors(@blog) == true
		redirect :"/blogs/#{@blog.id}"
	else
		redirect :"/blogs/new?#{catch_errors(@blog)}=true"
	end
end

delete '/blogs/all' do # Probably not RESTful, come back to this
	Blog.destroy(params[:selected_blog].keys)
	redirect :'blogs'
end

delete '/blogs/:id' do
	Blog.destroy(params[:id])
	redirect :'/blogs'
end

get '/blogs/:id' do
  erb :'blogs/show'
end

get '/blogs/:id/edit' do
	erb :'blogs/edit'
end

put '/blogs/:id' do
  current_blog.update(title: params[:title], description: params[:description], content: params[:content])
  redirect :"/blogs/#{current_blog.id}"
end