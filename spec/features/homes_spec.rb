require 'rails_helper'

RSpec.feature "adding posts" do
  scenario "Visit homepage" do
    visit root_path

    expect(page).to have_content("Home page")
  end
end
