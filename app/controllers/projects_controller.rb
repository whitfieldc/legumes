post '/projects' do
  api_client.create_project(params)
  redirect '/'
end

get '/projects/:id' do
  @task_set = api_client.get_project(params[:id])
  @task_set
  erb :show_project
end
