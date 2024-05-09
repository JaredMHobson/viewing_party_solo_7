require 'rails_helper'

RSpec.describe 'Movie Service' do
  it 'exists' do
    service = MovieService.new

    expect(service).to be_a MovieService
  end

  describe '#top_rated_movies', :vcr do
    it 'returns an array of the top rated movies data' do
      movies = MovieService.new.top_rated_movies
      movie1 = movies.first
      movie2 = movies.first

      expect(movies).to be_a Array
      expect(movie1).to have_key(:title)
      expect(movie1).to have_key(:vote_average)
      expect(movie2).to have_key(:title)
      expect(movie2).to have_key(:vote_average)
    end
  end

  describe '#movie_search' do
    it 'returns an array of movies data with a title that included the searched words', :vcr do
      movies = MovieService.new.movie_search('Harry Potter')
      movie1 = movies.first
      movie2 = movies.first

      expect(movies).to be_a Array

      expect(movie1).to have_key(:title)
      expect(movie1[:title]).to be_a String

      expect(movie1).to have_key(:vote_average)
      expect(movie1[:vote_average]).to be_a Float

      expect(movie2).to have_key(:title)
      expect(movie2[:title]).to be_a String

      expect(movie2).to have_key(:vote_average)
      expect(movie2[:vote_average]).to be_a Float

      movies.each do |mov|
        expect(mov[:title]).to include('Harry Potter')
      end
    end
  end

  describe '#get_url', :vcr do
    it 'returns a hash of the results from the argument API call' do
      response = MovieService.new.get_url('movie/top_rated')

      expect(response).to be_a Hash

      expect(response).to have_key(:page)
      expect(response[:page]).to be_a Integer

      expect(response).to have_key(:results)
      expect(response[:results]).to be_a Array

      expect(response).to have_key(:total_pages)
      expect(response[:total_pages]).to be_a Integer

      expect(response).to have_key(:total_results)
      expect(response[:total_results]).to be_a Integer
    end
  end

  describe '#conn' do
    it 'initializes a new Faraday connection ' do
      connection = MovieService.new.conn

      expect(connection).to be_a Faraday::Connection
    end
  end
end