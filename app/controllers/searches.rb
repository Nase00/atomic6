get '/blogs/search/:search_term' do
  search_term = params[:search_term]
  blogs = Blog.where("title like :kw or title like :kw", :kw=>"%#{search_term}%")
  content_type :json
  if blogs
    blogs.to_json(methods: [:html_content, :nice_time, :author], except: [:content] )
  else
    search_term.to_json
  end
end
