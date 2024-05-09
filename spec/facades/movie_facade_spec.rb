require 'rails_helper'

RSpec.describe 'Movie Facade' do
  it 'exists' do
    facade = MovieFacade.new

    expect(facade).to be_a MovieFacade
  end

  describe '#movies', :vcr do
    it 'creates a list of movies' do
      facade = MovieFacade.new('harry potter')

      movies = facade.movies

      movies.each do |movie|
        expect(movie).to be_a Movie
      end
    end
  end
end
