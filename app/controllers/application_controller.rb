require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"

  end

  get "/" do
    if Helpers.is_logged_in?(session)
      redirect "/lists"
    else
      redirect "/signup"
    end
  end

  helpers do 

    def current_user
        User.find_by(id: session[:user_id])
    end

    def is_logged_in?
        !!current_user
    end

    def authorize
        if !is_logged_in? || current_user.nil?
            redirect '/login'
        end
    end

    def authorize_list_access(list_id)
        user = current_user
        redirect '/logout' if !user.lists.find{|list| list.id == list_id.to_i}
        #  if user.id != list.user.id
    end

    def authorized?
        !!logged_in? && !current_user.nil?
    end

    def time_of_day
        hour = Time.now.to_s.split(" ")[1].split(":")[0].to_i
            if hour < 12
                "Morning"
            elsif hour < 17
                "Afternoon"
            else
                "Evening"
            end
    end

    def time_from_now(time)
            seconds = Time.now - time
            if seconds < 60
                return "#{seconds.to_i} seconds ago"
            elsif seconds < 3600
                return "#{(seconds / 60.0).to_i} minutes ago"
            elsif seconds < 86400
                return "#{(seconds / 3600.0).to_i} hours ago"
            elsif seconds < 604800
                return "#{(seconds / 86400.0).to_i} days ago"
            elsif seconds < 2419200
                return "#{(seconds / 604800.0).to_i} weeks ago"
            else
                return "on #{time}"
            end
    end
  end
  

end
