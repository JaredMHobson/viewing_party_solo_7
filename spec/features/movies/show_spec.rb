require 'rails_helper'

RSpec.describe 'Movies Index Page', type: :feature do
  describe 'User Story 2' do
    it '', :vcr do
      user = User.create!(name: 'Sam', email: 'sam@email.com')

      visit user_movie_path(user, 671)
    end
  end
end
