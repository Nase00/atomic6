helpers do
  def logged_in_user_id
    session[:logged_in_user_id]
  end

  def logged_in_user
    User.find(logged_in_user_id)
  end

  def logged_in?
    logged_in_user_id.present?
  end
end