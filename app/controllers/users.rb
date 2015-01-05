get '/users' do
	@users = User.all
  erb :'users/index'
end

# --- CHANGE PASSWORD
get '/users/password' do
	erb :'users/password'
end

post '/users/password' do
	if logged_in_user.authenticate(params[:old_password])
		logged_in_user.password = BCrypt::Password.create(params[:new_password])
		logged_in_user.password_confirmation = BCrypt::Password.create(params[:new_password_confirmation])
		if logged_in_user.update!(password: BCrypt::Password.create(params[:password]))
			redirect :"users/#{logged_in_user.id}"
		else
			redirect :"users/password?mismatch=true"
		end
	else
		redirect :"users/password?incorrect_password=true"
	end
	# if password_matcher
	# 	if logged_in_user.authenticate(params[:oldPassword])
	# 		logged_in_user.update(password: params[:newPassword])
	# 		redirect :"users/#{logged_in_user.id}"
	# 	else
	# 		redirect :"users/password?incorrect_password=true"
	# 	end
	# else
	# 	redirect :"users/password?mismatch=true"
	# end
end

get '/users/:id' do
	if logged_in?
		@user = User.find(params[:id])
	  erb :'users/show'
	else
		redirect '/login?must_login=true'
	end
end

get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
  @user = User.new(name: params[:name], email: params[:email], password: params[:password])
  if @user.save
  	session[:logged_in_user_id] = @user.id
    redirect :'/'
  else
    erb :'users/new'
  end
end

get '/users/:id/edit' do # Allow only admin to edit any user
  logged_in_user.is_admin	 ? @user = User.find(params[:id]) : @user = logged_in_user
  erb :'users/edit'
end

put '/users/:id' do
  @user = User.find(params[:id])
  if @user.authenticate(params[:password])
	  @user.update(name: params[:name], email: params[:email], twitter: params[:twitter])
	  redirect :"/users/#{@user.id}"
	else
		redirect :"/users/#{@user.id}/edit?incorrect_password=true"
	end
end