module SessionsHelper
    #methode qui nous permet de d'implementer le session[:id] avec l'id du user
    def log_in(user)
        session[:user_id] = user.id
    end    

    # Retourne l'utilisateur actuellement connecté
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
      
    end

    # return true si l'utilisateur est connecté
    def logged_in?
        !current_user.nil?
    end

    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token    
    end

    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # Logs out the current user.
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    #methode qui nous permet de d'implementer le session[:id] avec l'id du user
    def log_in(user)
        session[:user_id] = user.id
    end  
end
