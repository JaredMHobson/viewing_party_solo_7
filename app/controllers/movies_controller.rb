class MoviesController < ApplicationController
  def index
    @user ||= User.find(params[:user_id])

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:key]
    end

    response =
    if params[:search]
      search = params[:search].gsub(' ', '%20')
      conn.get("/3/search/movie?query=#{search}")
    else
      conn.get('/3/movie/top_rated')
    end

    data = JSON.parse(response.body, symbolize_names: true)

    @movies = data[:results][0..19]
  end

  def show
  end
end
