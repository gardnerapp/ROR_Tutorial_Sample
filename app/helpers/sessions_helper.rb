module SessionsHelper
    
# logs user in by setting K/V in sessions hash
    def log_in(user)
        session[:user_id] = user.id 
    end 
    
    #returns current user if any 
    def current_user
        if(user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id]) # decryption implicit
        raise #canary for determining if this branch is tested
            user = User.find_by(id: user_id)
            #does this part work when creating and thus logging in a new user, No remember token
            #was present 
            if user && user.authenticated?(cookies[:remember_token])
                log_in user 
                @current_user = user
            end 
        end 
    end

    #returns logged in status 
    def logged_in?
        # if nil true return false 
        !current_user.nil?
    end 
     
     #rembers user in persistent session, stores cookie in browsa
    def remember(user)
        user.remember # a model method creates token and updates attr
        cookies.permenant.encrypted[:user_id] = user.id #encrypts user id as K/V In cookies hash
        cookies.permenant[:remember_token] = user.remember_token
    end 
    
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil 
    end 
    
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delet(:remember_token)
    end 
    

end 