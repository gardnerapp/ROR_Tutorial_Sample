require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name: "example user", email: "example@examplemail.com",
    password: "FooPass", password_confirmation: "FooPass")
  end 
  
  test "should be valid" do 
    assert @user.valid?
  end 
  
  test "password should be present (non-blank)" do
    @user.password = @user.password_confirmation = " "* 6
    assert_not @user.valid?
  end
  
  test "password should have a minimuim length"do
    @user.password = @user.password_confirmation = "A"*5
    assert_not @user.valid?
  end
  
  test 'name should be present' do
    @user.name = "  "
    assert_not @user.valid?
  end 
  
  test 'email should be present' do
    @user.email = '      '
    assert_not @user.valid?
  end

  test 'name would be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end 

  test 'email would be too long' do 
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end
  
  
  test 'email validation should accept valid aderesses' do
    valid_addresses = %w[user@examplemail.com USER@foo.COM A-US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    
    #These emails fail because the rgex is wrong 
    #TODO Maybe? Fix Regex to get these emails to match 
    
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end 
    
  end
  
    test 'email validation should reject invalid aderesses' do
   invalid_addresses = %w[user@examplemal,.com user_at_foo.org  user.name@example.
   foo@bar_bar.com foo@bar+bar.com foo@bar..com
   ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} is invalid"
    end 
  end
  
  test 'email addresss should be unique' do
    duplicate_user = @user.dup 
    @user.save 
    assert_not duplicate_user.valid?
  end 
  
  
end
