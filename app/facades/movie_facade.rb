class MovieFacade
  attr_reader :movie

  def initialize(search: nil, id: nil)
    @search = search
    @id = id
    @service = MovieService.new
    @movie ||= find_movie
  end

  def find_movie
    if @id
      data = @service.find_movie(@id)

      movie_data = {
      id: data[:id],
      title: data[:title],
      vote_average: data[:vote_average],
      runtime: data[:runtime],
      genres: data[:genres],
      summary: data[:overview],
      cast: data[:credits][:cast],
      reviews: data[:reviews][:results]
    }

      Movie.new(movie_data)
    end
  end

  def movies
    results = (@search.nil? ? @service.top_rated_movies : @service.movie_search(@search))

    movies = results.map do |movie_data|
      Movie.new(movie_data)
    end

    movies.compact[0..19]
  end

  def movie_rental_services
    @service.find_movie_providers(@id)[:rent]
  end

  def movie_buy_services
    @service.find_movie_providers(@id)[:buy]
  end
end
