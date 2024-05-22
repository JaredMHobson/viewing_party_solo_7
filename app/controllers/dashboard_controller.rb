class DashboardController < ApplicationController
  def show
    if current_user
      @facade = MovieFacade.new
    else
      flash[:error] = "You must be logged in or registered to access a user's dashboard."
      redirect_to root_path
    end
  end
end
