# get '/' do
#   api = HackerNews::Client.new
#   erb :index
# end


get '/' do
  # if logged_in?
    # redirect '/home'
  # else
    erb :index
  # end
end

get '/key' do
  api = HackerNews::Client.new
  response = api.get('/key')
  "#{response}"
end

post '/users/login' do
  login(params[:email], params[:password])

end

post '/users' do

end
