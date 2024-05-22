class MoviesController < ApplicationController
  def index
    @facade =
      if params[:search]
        MovieFacade.new(search: params[:search])
      else
        MovieFacade.new
      end
  end

  def show
    @facade = MovieFacade.new(id: params[:id])
  end
end
