require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
  describe 'User Story 2' do
    it 'displays each movies title as a link to the movie details page, their Vote Average and theres a max of 20 results. It also has a button to the discover page', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com')

      visit user_discover_index_path(user)

      fill_in(:search, with: 'harry potter')
      click_button('Find Movies')

      within '#movie_list' do
        expect(page).to have_link("Harry Potter and the Philosopher's Stone", href: user_movie_path(user, 671))
      end
    end
  end
end
