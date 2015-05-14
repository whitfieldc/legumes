helpers do

  def current_user
    cookies[:user_id]
  end

  def login(email, password)
    api = GopherBan::Client.new
    args = { "email" => email, "password" => password }
    response = api.post('/users/login', args)
  end

  def logout

  end

  def logged_in?
    !!current_user
  end

end
