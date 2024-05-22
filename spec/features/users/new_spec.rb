require 'rails_helper'

RSpec.describe 'Create New User', type: :feature do
  describe 'When user visits /register' do
    before(:each) do
      visit register_user_path
    end

    it 'has a form to fill in their name, email, password and password confirmation' do
      expect(page).to have_field(:user_name)
      expect(page).to have_field(:user_email)
      expect(page).to have_field(:user_password)
      expect(page).to have_field(:user_password_confirmation)
      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it 'takes them to their dashboard page when they fill in the form with their name, email, password and password confirmation' do
      fill_in(:user_name, with: 'Tarzan')
      fill_in(:user_email, with: 'tarzcan113@yahoo.com')
      fill_in(:user_password, with: 'password113')
      fill_in(:user_password_confirmation, with: 'password113')
      click_button('Create New User')

      new_user = User.last

      expect(new_user.name).to eq('Tarzan')
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully Created New User')
    end

    describe '#sad_paths' do
      it 'does something' do
        fill_in(:user_name, with: '')
        fill_in(:user_email, with: '')
        fill_in(:user_password, with: 'password113')
        fill_in(:user_password_confirmation, with: 'password')
        click_button('Create New User')

        expect(current_path).to eq(register_user_path)
        expect(page).to have_content("Name can't be blank, Email can't be blank, Email is invalid, Password confirmation doesn't match Password")
      end
    end
  end
end
