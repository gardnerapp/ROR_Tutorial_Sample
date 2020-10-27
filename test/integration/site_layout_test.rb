require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end 

  test "layout links for logged in user" do
    log_in_as @user
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", users_path
    # not sure if current_user is the right path 
    assert_select "a[href=?]", current_user
    assert_select "a[href=?]", edit_user_path(current_user)
    assert_select "a[href=?]", logout_path
    #Sign Up should not be there if the user is logged in 
    #remove the following 
    get signup_path
    assert_select "title", full_title("Sign Up")
  end
  
  
  test "Layout Links for non-logged in user" do 
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", login_path
    
     get signup_path
    assert_select "title", full_title("Sign Up")
  end 

end
