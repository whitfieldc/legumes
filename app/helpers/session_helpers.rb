helpers do

  def session_key
    session[:session_key]
  end

  def session_key=(session_key)
    session[:session_key] = session_key
    @api_client = nil
  end

  def api_client
    @api_client ||= ApiClient.new(
      session_key: session_key,
    )
  end

  def login(email, password)
    response = api_client.login(email, password)
    raise response.inspect
    self.session_key = session_key
  end

  def logout

  end

  def current_user
    nil
  end

  def logged_in?
    !!current_user
  end

end
