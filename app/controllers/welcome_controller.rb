class WelcomeController < ApplicationController
  def index
    # flash[:notice] = "Logged in Successfully"
    # flash[:alarm] = "Invalid Credentials"
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      current_time = Time.now
      if @user.updated_at.strftime("%d%m%y") != current_time.strftime("%d%m%y")
        @user.update(usage: 0)
      end  
    end  
  end 
end    