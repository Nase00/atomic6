helpers do
  def logged_in_user_id
    session[:logged_in_user_id]
  end

  def logged_in_user
    User.find(logged_in_user_id)
	rescue ActiveRecord::RecordNotFound
		redirect :'/login?must_login=true'
  end

  def logged_in?
    logged_in_user_id.present?
  end

	def privilaged(model) # Determines element visibility based on user status
		if logged_in?
			owner_of?(model) || logged_in_user.is_admin
		else
			false
		end
	end

  def owner_of?(model) # Validates if the user created the blog or comment they are viewing
		case model
		when Blog
			model.author.id == logged_in_user.id
		when Comment
			model.commenter.id == logged_in_user.id
		else
			false
		end
	end

	# def password_matcher
	# 	params[:newPassword] == params[:confirmPassword]
	# end
end