require 'rails_helper'

RSpec.describe 'Similar Index Page', type: :feature do
  before(:each) do
    @user = User.create!(name: 'Sam', email: 'sam@email.com', password: Faker::Internet.password)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'User Story 6' do
    it 'has a list of 5 similar movies with their title, overview, release date, poster image and vote average', :vcr do
      visit movie_similar_index_path(767)

      muppet_summary = 'A retelling of the classic Dickens tale of Ebenezer Scrooge, miser extraordinaire. He is held accountable for his dastardly ways during night-time visitations by the Ghosts of Christmas Past, Present and Future.'

      expect(page).to have_content("Title: Aura: Koga Maryuin's Last War")
      expect(page).to have_content('Release Date: 2013-04-13')
      expect(page).to have_content('Vote: 6.37')

      expect(page).to have_content('Title: The Muppet Christmas Carol')
      expect(page).to have_content('Release Date: 1992-12-10')
      expect(page).to have_content('Vote: 7.4')
      expect(page).to have_content("Summary: #{muppet_summary}")

      expect(page).to have_css('img', count: 5)
    end
  end
end
