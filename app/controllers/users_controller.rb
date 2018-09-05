require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    redirect "/signup" if Helpers.is_logged_in?(session)
    erb :'users/create_user'
  end


  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save
      session[:user_id] = @user.id
      redirect '/lists'
    else
      flash[:message] = "#{@user.errors.full_messages.join(", ")}"
      redirect '/signup'
    end
  end
 

  get '/login' do
    redirect "/lists" if Helpers.is_logged_in?(session)    
    erb :"/users/login"
    
  end
  
  
  post '/login' do
  
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      redirect '/lists'
    else
      flash[:message] = "Log In failed. Please try again"
      redirect '/login'
    end
  end
  
  
  
  
  get '/logout' do
    session.clear
    redirect '/login'
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
