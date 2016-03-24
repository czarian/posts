require "rails_helper"


RSpec.feature "Comments test" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.build(:post, user: user) }
  let!(:comment) {FactoryGirl.build(:comment, user: user, post: post) }
  before(:each) do
    login_as(user, :scope => :user)
    visit new_post_path
    fill_in "Title", with: post.title
    fill_in "Body", with: post.body
    click_on("Create")
  end


  scenario "Show comment form in post" do

    expect(page).to have_content("Some title")
    expect(page).to have_content("Some body")
    expect(page).to have_selector("#comment_body")
    expect(page).to have_selector("input[type=submit][value='Create post']")

    expect(page).to have_selector("#comment_post_id")
    expect(page).to_not have_selector("#post_body")


  end

  scenario "Restict save comment without fill body" do

    click_on("Create post")

    expect(page).to have_content("Some title")
    expect(page).to have_content("Some body")
    expect(page).to have_content("John Doe")

    expect(page).to_not have_selector("#comment_body")

    expect(page).to_not have_selector("#comment_post_id")
    expect(page).to_not have_selector("#post_body")


  end

  scenario "Create new comment" do
    fill_in "Body", with: comment.body

    click_on("Create post")

    expect(page).to have_content("Some title")
    expect(page).to have_content("Some body")
    expect(page).to have_content("John Doe")

    expect(page).to have_selector("#comment_body")
    expect(page).to have_content("Some comment body")

  end

end
