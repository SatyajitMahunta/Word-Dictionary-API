class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end 
  
  def create
    #render plain: "Thanks" 
    @user = User.new(user_params)
    if @user.save 
      redirect_to root_path, notice:"Successfully Created Account :)"
    else
      render :new
    end    
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :plan_type)
  end  
end    