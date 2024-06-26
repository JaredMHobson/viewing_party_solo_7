class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      cookies.encrypted[:user_id] = { value: new_user.id, expires: 1.month }
      session[:user_id] = new_user.id
      flash[:success] = 'Successfully Created New User'
      redirect_to dashboard_path
    else
      flash[:error] = "#{error_message(new_user.errors)}"
      redirect_to register_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
