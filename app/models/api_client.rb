class ApiClient

  def initialize(options)
    @access_token = options.fetch(:access_token)
    # @base_uri = "https://peaceful-sierra-3742.herokuapp.com/"
    @base_uri = 'http://localhost:9393'
    @headers = {  }
  end

  def login(email, password)
    post('/users/login',
      email: email,
      password: password,
    )
  end

  def signup(email, password)
    post('/users',
      email: email,
      password: password,
    )
  end

  def projects
    authorized_get('/projects')
  end

  def create_project(params)
    authorized_post('/projects', params)
  end

  def get_project(id)
    authorized_get("/projects/#{id}")
  end

  def create_task(params)
    authorized_post("/projects/#{params[:id]}/tasks", params)
  end

  def update_task(params)
    authorized_patch("/tasks/#{params[:id]}", params)
  end

  def delete_task(id)
    authorized_delete("/tasks/#{id}")
  end

  def get(path, params={}, headers={})
    response = HTTParty.get("#{@base_uri}#{path}",
      params: params,
      headers: headers,
    )
    response.parsed_response
  end

  def post(path, params={}, headers={})
    response = HTTParty.post(
      "#{@base_uri}#{path}",
      headers: headers,
      body: params,
    )
    response.parsed_response
  end

  def patch(path, params={}, headers={})
    response = HTTParty.patch(
      "#{@base_uri}#{path}",
      headers: headers,
      body: params,
      )
    response.parsed_response
  end

  def delete(path, params={}, headers={})
    response = HTTParty.delete(
      "#{@base_uri}#{path}",
      headers: headers,
      )
    response.parsed_response
  end

  def authorized_delete(path, params={}, headers={})
    ensure_access_token!
    headers["KEY"] = @access_token
    delete(path)
  end

  def authorized_patch(path, params={}, headers={})
    ensure_access_token!
    headers["KEY"] = @access_token
    patch(path, params, headers)
  end

  def authorized_post(path, params={}, headers={})
    ensure_access_token!
    headers["KEY"] = @access_token
    post(path, params, headers)
  end

  def authorized_get(path, params={}, headers={})
    ensure_access_token!
    headers["KEY"] = @access_token
    get(path, params, headers)
  end

  private

  def ensure_access_token!
    raise "No session key" if @access_token.nil?
  end

end
