class Helpers
    def self.current_user(session)
        User.find_by(id: session[:user_id])
    end

    def self.is_logged_in?(session)
        !!current_user(session)
    end

    def self.time_of_day
        hour = Time.now.to_s.split(" ")[1].split(":")[0].to_i
            if hour < 12
                "Morning"
            elsif hour < 17
                "Afternoon"
            else
                "Evening"
            end
    end

    def self.time_from_now(time)
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