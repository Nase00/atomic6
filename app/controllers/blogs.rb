get '/blogs' do
  @blogs = Blog.all
  erb :'blogs/index'
end

get '/blogs/new' do
	erb :'blogs/new'
end

post '/blogs' do
	@blog = Blog.new(title: params[:title], description: params[:description], content: params[:content], author_id: logged_in_user.id)
	if @blog.save
		redirect :"/blogs/#{@blog.id}"
	else
		erb :'/blogs/new'
	end
end

get '/blogs/:id' do
  erb :'blogs/show'
end

get '/blogs/:id/edit' do
	erb :'blogs/edit'
end

put '/blogs/:id' do
	# if params[:content]
	  current_blog.update(title: params[:title], description: params[:description], content: params[:content])
	  redirect :"/blogs/#{current_blog.id}"
	# else
	# 	# erb :"/blogs/#{current_blog.id}/edit?too_long=true"
	# end
end