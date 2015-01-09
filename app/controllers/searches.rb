get '/blogs/search/:search_term' do
  search_term = params[:search_term]
  blog = Blog.find_by(title: search_term)
  content_type :json
  if blog
    blog.to_json
  else
    search_term.to_json
  end
end
