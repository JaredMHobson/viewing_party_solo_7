require 'rails_helper'

RSpec.describe 'Movie' do
  it 'exists and has attributes' do
    details = {
      id: 1,
      title: 'Inception',
      vote_average: 99.9999
    }

    movie = Movie.new(details)

    expect(movie).to be_a Movie
    expect(movie.id).to eq(1)
    expect(movie.title).to eq('Inception')
    expect(movie.vote_average).to eq(99.9999)
  end
end
