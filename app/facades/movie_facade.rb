class MovieFacade
  def initialize(search = nil)
    @search = search
  end

  def movies
    service = MovieService.new

    results = (@search.nil? ? service.top_rated_movies : service.movie_search(@search))

    movies = results.map do |movie_data|
      Movie.new(movie_data)
    end

    movies.compact[0..19]
  end
end
