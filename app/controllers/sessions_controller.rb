class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to user_path(user)
    else
      flash[:error] = 'Invalid email address or password.'
      render :new
    end
  end

  def destroy
    reset_session
    flash[:success] = 'Logged out successfully.'
    redirect_to root_path
  end
end
