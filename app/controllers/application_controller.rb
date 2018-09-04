require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  get '/lists/new' do
    redirect_if_not_logged_in
    erb :'/lists/new'
  end
  
  post '/lists/new' do
    list = List.create(:name => params[:name], :user_id => session[:user_id])
    task = Task.create(:name => params[:tasks][:name])
    list.tasks << task unless list.tasks.include?(task)
    redirect '/tasks'
  end

end
