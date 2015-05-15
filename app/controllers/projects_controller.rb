post '/projects' do
  api_client.create_project(params)
  redirect '/'
end

get '/projects/:id' do
  # binding.pry
  if params[:id].length < 3
    @task_set = api_client.get_project(params[:id])
  end
  # TWO REQUESTS ON THIS ROUTE?
  # binding.pry
  # p @task_set
  erb :show_project
end

get 'projects/:project_id/tasks/new' do
  erb :_new_task
end
