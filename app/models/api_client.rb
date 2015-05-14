class ApiClient

  def initialize(options)
    @session_key = options.fetch(:session_key)
    @base_uri = "http://localhost:9494"
    @headers = {  }
  end

  def login(username, password)
    post('/users/login',
      username: username,
      password: password,
    )
  end

  def get(path, params={})
    response = HTTParty.get("#{@base_uri}#{path}",
      params: params,
    )
    response.parsed_response
  end

  def post(path, params={}, headers={})
    response = HTTParty.post(
      "#{@base_uri}#{path}",
      headers: @headers,
      body: params,
    )
    response.parsed_response
  end

  def authorized_post(path, params={}, headers={})
    ensure_session_key!
    headers["KEY"] = @session_key
    post(path, params, headers)
  end

  private

  def ensure_session_key!
    raise "No session key" if @session_key.nil?
  end

end
