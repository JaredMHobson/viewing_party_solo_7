class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :summary,
              :cast,
              :reviews,
              :rent,
              :buy

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @summary = attributes[:summary]
    @cast = attributes[:cast]
    @reviews = attributes[:reviews]
    @rent = attributes[:rent]
    @buy = attributes[:buy]
  end

  def runtime_converted
    "#{@runtime / 60} hr #{@runtime % 60} min"
  end

  def genre_names
    @genres.map do |genre|
      genre[:name]
    end.join(', ')
  end

  def review_count
    @reviews.count
  end

  def top_ten_cast
    @cast[0..9]
  end
end
