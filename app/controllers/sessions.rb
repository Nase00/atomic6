# --- LOGIN

get '/login' do
  @no_user = params["no_user"] == "true"
  @login_error = params["login_error"] == "true"
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    # content_type :json
    # @user.to_json
    session[:logged_in_user_id] = @user.id
    redirect '/'
  elsif @user.nil?
    redirect '/login?no_user=true'
  else
    redirect '/login?login_error=true'
  end
end

# --- REGISTER

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

# --- LOGOUT

get '/logout' do
  session[:logged_in_user_id] = nil
  redirect '/'
end