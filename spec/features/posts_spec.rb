require "rails_helper"

RSpec.feature "adding posts" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.build(:post, user: user) }

  scenario "Restrict to add post without login" do



    visit new_post_path
    fill_in "Title", with: "Some title"
    fill_in "Body", with: "Some body"

    click_on("Create")

    expect(page).to have_content("Log in")

  end

  scenario "Add post after user login" do

  #visit new_user_session_path
  #fill_in "user_email", :with => user.email
  #fill_in "user_password", :with => user.password
  #click_on("Log in")
  login_as(user, :scope => :user)

  visit new_post_path
  fill_in "Title", with: post.title
  fill_in "Body", with: post.body
  click_on("Create")

    expect(page).to have_content("Some title")
    expect(page).to have_content("Some body")
  end

  scenarion "Restrict adding post without title" do
    login_as(user, :scope => :user)

    visit new_post_path
    fill_in "Body", with: post.body
    click_on("Create")


  end



end
