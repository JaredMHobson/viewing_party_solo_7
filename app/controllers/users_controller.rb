class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    if params[:id].to_i == session[:user_id]
      @user = User.find(params[:id])
      @facade = MovieFacade.new
    else
      flash[:error] = "You must be logged in or registered to access a user's dashboard."
      redirect_to root_path
    end
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      cookies.encrypted[:user_id] = { value: new_user.id, expires: 1.month }
      session[:user_id] = new_user.id
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(new_user)
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
