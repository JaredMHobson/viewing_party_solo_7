class ApplicationController < ActionController::Base
  def current_user
    User.find(params[:id])
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
