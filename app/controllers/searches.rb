get '/blogs/search/:search_term' do
  search_term = params[:search_term]
  blogs = Blog.where("title like :kw or title like :kw", :kw=>"%#{search_term}%")
  # blogs = Blog.where(title: search_term)
  content_type :json
  if blogs
    blogs.to_json(methods: [:html_content, :time, :author], except: [:content] )
    # {blogs: blogs, authors: blogs.authors}.to_json
  else
    search_term.to_json
  end
end
