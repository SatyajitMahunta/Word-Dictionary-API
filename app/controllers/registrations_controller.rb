class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end 
  
  def create
    #render plain: "Thanks" 
    @user_p = user_params
    @user_p["usage"] = 0
    @user = User.new(@user_p)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to root_path, notice:"Successfully Created Account :)"
    else
      render :new
    end    
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :plan_type, :usage)
  end  
end    