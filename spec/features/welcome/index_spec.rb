require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
  describe 'When a user visits the root path "/"' do
    before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: Faker::Internet.password)
      @user_2 = User.create!(name: 'Tommy', email: 'tommy_t@gmail.com', password: Faker::Internet.password)

      visit root_path
    end

    it 'They see title of application, and link back to home page' do
      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
    end

    it 'They see button to create a New User' do
      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it 'when logged in, they see a list of existing users email addresses' do
      click_on('Log In')

      within '.login_form' do
        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password

        click_on "Log In"
      end

      visit root_path

      within('#existing_users') do
        expect(page).to have_content(User.first.email)
        expect(page).to have_content(User.last.email)
      end
    end

    it 'when not logged in, they do not see the list of existing users and only see the create new user button' do
      expect(page).to_not have_css('#existing_users')
      expect(page).to_not have_content(User.first.email)
      expect(page).to_not have_content(User.last.email)

      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it 'They see a link to go back to the landing page (present at the top of all pages)' do
      expect(page).to have_link('Home')
    end

    it 'has a link to the login page' do
      click_on('Log In')

      expect(current_path).to eq(login_path)
    end
  end
end
