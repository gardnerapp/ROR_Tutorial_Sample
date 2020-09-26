require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

 # simulates signup with invalid information
  test "invalid signup information" do 
    # go to signup Path 
    get signup_path
    # measures the number of users before and after doing a post to User with invalid information
    assert_no_difference 'User.count' do 
      #invalid post ie. should not do anything 
      post users_path, params: {
        user: {
          name: "",
          email: "invalid@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end 
    #makes sure we get the right template when the POST is invalid 
    assert_template "users/new"
    # goes into the users/ new and checks for the errors partial by selecting divs 
  assert_select 'div[id=?]', "error-explenation"
  assert_select 'div[class=?]', "alert alert-danger"
  end 
  
  

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count',1 do 
      post users_path, params: {user: {
        name: "new user", 
        email: "hog@hogmail.com",
        password: "111111",
        password_confirmation: "111111"
      }
      }
  end 
  follow_redirect!
  assert_template 'users/show'
  assert is_logged_in?

end
end
