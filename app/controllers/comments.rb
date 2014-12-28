get '/blogs/:id/comments/new' do
  "You shouldn't be seeing this!"
end

post '/blogs/:blog_id/comments' do
	comment = Comment.new(title: params[:title], content: params[:content], blog_id: current_blog.id, commenter_id: logged_in_user.id)
	content_type :json
	comment.save
	comment.to_json
end

delete '/blogs/:blog_id/comments/:comment_id' do
	Comment.destroy(params[:comment_id])
	redirect :"/blogs/#{params[:blog_id]}?display_comments=true"
end

get '/blogs/:blog_id/comments/:comment_id/edit' do
	@comment = params[:commenter_id]
	erb :'/blogs/comments/edit'
end

put '/blogs/:blog_id/comments/:comment_id' do
  current_comment.update(title: params[:title], content: params[:content])
  redirect :"/blogs/#{current_blog.id}?display_comments=true"
end