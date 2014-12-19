helpers do
  def latest_blogs
    Blog.where(created_at: (Time.now - 1.day)..Time.now)
  end
end
