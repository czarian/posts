require "rails_helper"

RSpec.feature "User sign in/ sign up" do
  let!(:user) { FactoryGirl.build(:user) }

  scenario "Successfully sign up" do
    visit new_user_registration_path

    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password

    click_button "Sign up"

    expect(page).to have_content user.email
    expect(page).to have_content user.first_name

  end
end
