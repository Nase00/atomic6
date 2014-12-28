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

	def privilaged # Determines element visibility based on user status
		if logged_in?
			authored_blog || logged_in_user.is_admin
		else
			false
		end
	end

	def password_matcher
		params[:newPassword] == params[:confirmPassword]
	end
end