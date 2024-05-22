require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Tarzan", email: 'tarzan113@email.com', password: "hunter8")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "Tarzan", email: 'tarzan113@email.com', password: "hunter8")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: 'wrong password'

      click_on "Log In"
    end

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Invalid email address or password.")
  end

  it 'can log out once you are logged in' do
    user = User.create(name: "Tarzan", email: 'tarzan113@email.com', password: "hunter8")

    visit root_path

    expect(page).to_not have_button('Log Out')

    click_on "Log In"

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"
    end

    click_on 'Log Out'

    expect(page).to have_content('Logged out successfully.')
  end

  it 'has a field to enter your location that is stored within a cookie and your location will be visible on the landing page' do
    user = User.create(name: 'Tarzan', email: 'tarzan113@email.com', password: 'hunter8')

    visit root_path

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      fill_in :location, with: 'the jungle'

      click_on "Log In"
    end

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content('Location: the jungle')
  end

  it 'when you log out and click log in again, the location field will already be filled out with your previously entered location' do
    user = User.create(name: 'Tarzan', email: 'tarzan113@email.com', password: 'hunter8')

    visit root_path

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    within '.login_form' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      fill_in :location, with: 'the jungle'

      click_on "Log In"
    end

    expect(page).to have_content('Location: the jungle')

    click_on 'Log Out'

    click_on 'Log In'

    within '.login_form' do
      expect(page).to have_field(:location, with: 'the jungle')
    end
  end
end
