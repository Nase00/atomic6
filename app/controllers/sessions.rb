# --- LOGIN
get '/login' do
  @no_user = params["no_user"] == "true"
  @login_error = params["login_error"] == "true"
  @must_login = params["must_login"] == "true"
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    session[:logged_in_user_id] = @user.id
    redirect :'/'
  elsif @user.nil?
    redirect :'/login?no_user=true'
  else
    redirect :'/login?login_error=true'
  end
end

# --- LOGOUT
get '/logout' do
  session[:logged_in_user_id] = nil
  redirect :'/'
end