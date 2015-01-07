get '/blogs/:id/comments/new' do
  "You shouldn't be seeing this!"
end

get '/blogs/:blog_id/comments' do
	redirect :"/blogs/#{params[:blog_id]}?display_comments=true"
end

get '/blogs/:blog_id/comments/:comment_id' do
	redirect :"/blogs/#{params[:blog_id]}?display_comments=true#comment_#{params[:comment_id]}"
end

post '/blogs/:blog_id/comments' do
	comment = Comment.new(title: params[:title], content: params[:content], blog_id: current_blog.id, commenter_id: logged_in_user.id)
	content_type :json
	comment.save
	comment.to_json(methods: [:html_content])
end

delete '/blogs/:blog_id/comments/:comment_id' do
	Comment.destroy(params[:comment_id])
	redirect :"/blogs/#{params[:blog_id]}/comments"
end

get '/blogs/:blog_id/comments/:comment_id/edit' do
	@comment = Hash.new # Prevents ugly nil error
	erb :'/blogs/comments/edit'
end

put '/blogs/:blog_id/comments/:comment_id' do
	if catch_errors(current_comment, params[:editComment], "update") === true
	  redirect :"/blogs/#{current_blog.id}/comments"
	else
		@comment = params[:editComment]
		@error_message = catch_errors(current_blog, params[:editComment], "update")
		erb :"/blogs/comments/edit"
	end
end

get '/blogs/comments/by_user/:user_id' do
	@page_title = "Comments by " + User.find(params[:user_id]).name
	@comments = Comment.where(commenter_id: params[:user_id])
	erb :'/blogs/comments/index'
end
