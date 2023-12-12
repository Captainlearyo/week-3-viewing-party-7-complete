class UsersController < ApplicationController 
  def new
    @user = User.new
    render :new
  end

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = user_params
    user[:name] = user[:name].downcase
    new_user = User.create(user)
    session[:user_id] = new_user.id
    if new_user.save && user[:password] == user[:password_confirmation]
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form
  end

  def login
    user = User.find_by(name: params[:name])
    #binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash.now[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 