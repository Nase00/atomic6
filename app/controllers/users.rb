get '/users' do
	@users = User.all
  erb :'users/index'
end

get '/users/:id' do
	if logged_in?
	  erb :'users/profile'
	else
		redirect '/login'
	end
end