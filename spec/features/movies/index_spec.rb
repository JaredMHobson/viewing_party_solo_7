require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
  before(:each) do
    @user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'User Story 2' do
    it 'displays each movies title as a link to the movie details page and their Vote Average', :vcr do
      visit discover_index_path

      fill_in(:search, with: 'harry potter')
      click_button('Find Movies')

      within '#movie_list' do
        within '#movie_671_info' do
          expect(page).to have_link("Harry Potter and the Philosopher's Stone", href: movie_path(671))
          expect(page).to have_content('Vote Average: 7.91')
        end

        within '#movie_767_info' do
          expect(page).to have_link('Harry Potter and the Half-Blood Prince', href: movie_path(767))
          expect(page).to have_content('Vote Average: 7.69')
        end
      end
    end

    it 'displays a max of 20 movies', :vcr do
      visit movies_path

      within '#movie_list' do
        expect(page).to have_content('Vote Average:', maximum: 20)
      end
    end

    it 'has a button to the discover page', :vcr do
      visit movies_path

      click_button('Discover Page')

      expect(current_path).to eq(discover_index_path)
    end
  end
end
