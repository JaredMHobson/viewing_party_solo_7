class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||=
      if session[:user_id]
        User.find(session[:user_id])
      elsif cookies[:user_id]
        User.find(cookies.encrypted[:user_id])
      end
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
