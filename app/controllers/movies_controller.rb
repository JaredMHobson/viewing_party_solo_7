class MoviesController < ApplicationController
  def index
    @user ||= User.find(params[:user_id])

    @facade =
      if params[:search]
        MovieFacade.new(search: params[:search])
      else
        MovieFacade.new
      end
  end

  def show
    @user ||= User.find(params[:user_id])
    @movie = MovieFacade.new(id: params[:id]).movie
  end
end
