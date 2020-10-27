require 'test_helper'

#session[:user_id] is set in other test 
#these test are used to mitigate this
#why does session[:user_id] need to not be set when writing these test

class SessionsHelperTest < ActionView::TestCase
    
    def setup
        @user = users(:michael)
        remember(@user)
    end
    
    #asserts to users are the same 
    test 'current_user returns right user when session is nil' do
        #current user is a method in sessions helper 
        #asserts that set up user is the same as current user 
        assert @user, current_user
        assert is_logged_in?
    end 
    
    test 'current_user returns nil when remember digest is wrong' do 
        #give user a randomn token, current user will return nil because
        #the current user method relies on the rember token to find user 
        #rember token is digest for user ID this test elsif branch by providng\
        #randomn token
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        assert_nil current_user
    end 
    
    
end 