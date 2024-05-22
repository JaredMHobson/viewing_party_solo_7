require 'rails_helper'

RSpec.describe 'Viewing Party Show Page', type: :feature do
  before(:each) do
    @user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'User Story 5' do
    it 'shows logos of video providers where you can buy the movie and rent the movie, it shows data attribution for the JustWatch platform',
       :vcr do
      party_details = {
        duration: 180,
        date: Date.tomorrow,
        start_time: '19:00',
        movie_id: 767
      }
      party = ViewingParty.create!(party_details)

      visit movie_viewing_party_path(767, party)

      within '#buy_movie' do
        expect(page).to have_content('Buy:')
        expect(page).to have_css('img', count: 7)
      end

      within '#rent_movie' do
        expect(page).to have_content('Rent:')
        expect(page).to have_css('img', count: 7)
      end

      expect(page).to have_content('Buy/Rent data provided by JustWatch')
    end
  end
end
