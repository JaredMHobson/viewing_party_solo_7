require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  before(:each) do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: Faker::Internet.password)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'User Story 1' do
    it 'has a button to discover top rated movies, a text field to enter keyword(s) to search by movie title, and a button to search by movie title',
       :vcr do
      visit discover_index_path

      expect(page).to have_button('Find Top Rated Movies')
      expect(page).to have_button('Find Movies')
      fill_in(:search, with: 'Shawshank')
      click_button('Find Movies')

      expect(current_path).to eq(movies_path)

      visit discover_index_path

      click_button('Find Top Rated Movies')

      expect(current_path).to eq(movies_path)
    end
  end
end
