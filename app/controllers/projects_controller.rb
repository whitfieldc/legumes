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

post '/projects/:id/tasks' do
  response = api_client.create_task(params)
  if response
    erb :"partials/_small_task", locals: {
      title: response["title"],
      task_id: response["id"],
      detail: response["description"]
    }, layout: false
  end
end

get '/projects/:id/tasks/new' do
  erb :"partials/_new_task"
end

patch '/tasks/:id' do
  response = api_client.update_task(params)
end

delete '/tasks/:id' do
  response = api_client.delete_task(params[:id])
end
