class ListsController < ApplicationController

  get '/lists' do
    authorize
    @user = Helpers.current_user(session)
    @lists = @user.lists
    erb :'/lists/list'

  end

  get "/lists/new" do
    authorize
    erb :'/lists/create_list'
  end

  post '/lists' do
    user = Helpers.current_user(session)
    list = List.new(name: params[:list])
    if list.save
      user.lists << list
      user.save
      redirect "/lists/#{list.id}"
    else
      redirect '/lists/new'
    end
  end
  get '/lists/:id/edit' do
    @list = List.find_by_id(params[:id])
    if Helpers.is_logged_in?(session)
      authorize_list_access(params[:id])
      erb :'/lists/edit'
    else
      redirect '/login'
    end
  end

  get '/lists/:id' do
    authorize
    authorize_list_access(params[:id])
    @list = List.find_by_id(params[:id])
    erb :'/lists/show'
  end
  
  patch '/lists/:id' do
    authorize
    authorize_list_access(params[:id])
    list = List.find_by_id(params[:id])
    if !!params[:tasks]
      params[:tasks].each do |task_id| 
        task = list.tasks.find{|task| task.id == task_id.to_i }
        task.update(complete: true) if !!task
      end 
    end
    if params[:new_task] && params[:new_task].length > 0
      task = Task.create(name: params[:new_task])
      list.tasks << task
    end
    if list.save
      redirect "/lists/#{list.id}"
    else
      redirect "/lists/#{list.id}/edit"
    end
  end

  delete '/lists/:id' do
    @list = List.find(params[:id])
    if Helpers.is_logged_in?(session) && @list.user == Helpers.current_user(session)
      @list.delete
      redirect '/lists'
    
    end
  
  end
end

