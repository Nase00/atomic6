get '/blogs/:id/comments/new' do
  "Something went wrong"
end

post '/blogs/:id/comments' do
	comment = Comment.new(title: params[:title], content: params[:content], blog_id: current_blog.id, commenter_id: logged_in_user.id)
	content_type :json
	comment.save
	comment.to_json
end