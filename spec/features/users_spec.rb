require "rails_helper"

RSpec.feature "User sign in/ sign up" do

  let!(:user) { FactoryGirl.build(:user) }

  let!(:user2) { FactoryGirl.create(:user, email: "user2@gmail.com", first_name: "Czarek") }
  let!(:post) { FactoryGirl.build(:post, user: user2) }

  let!(:user3) { FactoryGirl.create(:user, email: "user3@gmail.com", first_name: "Jan") }
  let!(:post2) { FactoryGirl.build(:post, user: user3) }

  scenario "Successfully sign up" do
    visit new_user_registration_path

    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password

    click_button "Sign up"

    expect(page).to have_content user.first_name

  end

  scenario "Show users post" do

    login_as(user2, :scope => :user)

    #10.times do
      visit new_post_path
      fill_in "Title", with: post.title
      fill_in "Body", with: post.body
      click_on("Save")
    #end

    logout(:user)

    login_as(user3, :scope => :user)


    #10.times do
      visit new_post_path
      fill_in "Title", with: post.title
      fill_in "Body", with: post.body
      click_on("Save")
    #end

    logout(:user)

    visit posts_user_path(user2)
    expect(page).to have_content "#{user2.first_name} #{user2.last_name}"
    expect(page).to have_css ".thumbnail"
    expect(page).to_not have_content user3.first_name

  end
end
