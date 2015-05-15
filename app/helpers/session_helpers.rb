helpers do

  def access_token
    session[:access_token]
  end

  def access_token=(access_token)
    session[:access_token] = access_token
    @api_client = nil
  end

  def api_client
    @api_client ||= ApiClient.new(access_token: access_token)
  end

  def login(email, password)
    response = api_client.login(email, password)
    raise "failed login #{response["error"]}" if response["error"]
    self.access_token = response["access_token"]
  end

  def signup(email, password)
    response = api_client.signup(email, password)
    raise "failed signup #{response["error"]}" if response["error"]
    self.access_token = response["access_token"]
  end

  def logout
    session.clear
  end

  def logged_in?
    !access_token.nil?
  end

end
