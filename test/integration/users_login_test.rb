require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  
  test 'login with valid email/invalid password' do
    get login_path
    
    post login_path,  params: {
      session: {
        email: @user.email,
        password: "invid",
        }
    }
    
  assert_not is_logged_in?
  assert_template 'sessions/new'
  assert_not flash.empty?
  get root_path
  assert flash.empty?

  end
  
  
  test 'Login With Entirely valid information followed by logout' do
     get login_path
     assert_not is_logged_in?
     post login_path,  params: {
      session: {
        email: @user.email,
        password: "password",
        }
    }
    assert is_logged_in?
    assert_redirected_to @user 
  follow_redirect!
   assert_template "users/show"
   assert_select "a[href=?]", login_path, count: 0
   assert_select "a[href=?]", logout_path
   assert_select  "a[href=?]", user_path(@user)
   delete logout_path
   assert_not is_logged_in?
   assert_redirected_to root_url
   #simulate user clicking logout in second window
   delete logout_path
   #2nd time logout occurs, should raise error because current_user is missing 
   follow_redirect!
    assert_select "a[href=?]", login_path
   assert_select "a[href=?]", logout_path, count: 0
   assert_select  "a[href=?]", user_path(@user), count: 0
  end 
  
  test 'login with remembering'do 
      log_in_as(@user, remember_me: '1') #method found in test_helper.rb
      assert_equal cookies['remember_token'] , assigns(:user).remember_token
  end 
  
  test 'login without remembering' do 
      #Login and set the cookie 
      log_in_as(@user, remember_me: '1')
      assert_not_nil cookies['remember_token']
      #log in again and assert that the cookie is deleted
      log_in_as(@user, remember_me: '0')
      assert_nil cookies['remember_token']
  end 
  
end
