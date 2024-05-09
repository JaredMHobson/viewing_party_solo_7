require 'rails_helper'

RSpec.describe 'Movie Facade' do
  it 'exists' do
    facade = MovieFacade.new

    expect(facade).to be_a MovieFacade
  end

  describe '#movie', :vcr do
    it 'creates a movie' do
      harry_potter = MovieFacade.new(id: 767).movie

      expect(harry_potter).to be_a Movie
    end
  end

  describe '#movies', :vcr do
    it 'creates a list of movies' do
      facade = MovieFacade.new(search: 'harry potter')

      movies = facade.movies

      movies.each do |movie|
        expect(movie).to be_a Movie
      end
    end
  end
end
