class SessionsController < ApplicationController
  
  def new
  end
  
  def create 
    #params is hash of request and session is a hash within this hash 
    #finds the user via eamil
    
   @user = User.find_by(email: params[:session][:email].downcase)
    #if users email is correct and the useres password is correct
    if @user&.authenticate(params[:session][:password])
      # creates cookie from login method helpers/sessions_helper.rb
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else 
      #flash now disappears once there is an additional request 
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end 
  
  # logs out by destroying a session 
  def destroy
   log_out if logged_in?
   redirect_to root_url 
  end
end

#logging out 
#url =>view =>  helper methods  => model methods  
