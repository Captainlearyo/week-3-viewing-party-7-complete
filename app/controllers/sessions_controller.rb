class SessionsController < ApplicationController 

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private 
  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 