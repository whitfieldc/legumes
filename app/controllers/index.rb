# get '/' do
#   api = HackerNews::Client.new
#   erb :index
# end
enable :sessions

get '/' do
  if logged_in?
    ###### create display for all projects, PARTIALIZE
    @projects = api_client.projects
  end
  erb :index
end

post '/users' do
  signup(params[:email], params[:password])
  if logged_in?
    redirect to('/')
  else
    erb :index
  end
end

post '/users/login' do
  login(params[:email], params[:password])
  if logged_in?
    redirect to('/')
  else
    erb :index
  end
  # get @key from backend JSON
  # set session key info to @key
  # redirect to homepage
  # send session key and username in headers with successive requests
end

post '/logout' do
  logout
  redirect '/'
end


