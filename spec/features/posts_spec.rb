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

  login_as(user, :scope => :user)

    visit new_post_path
    fill_in "Title", with: post.title
    fill_in "Body", with: post.body
    click_on("Create")

    expect(page).to have_content("Some title")
    expect(page).to have_content("Some body")
  end

  scenario "Restrict adding post without title and body" do
    login_as(user, :scope => :user)

    visit new_post_path

    click_on("Create")

    expect(page).to have_selector("#post_body")
    expect(page).to_not have_content("Some title")
    expect(page).to_not have_content("Some body")


  end

  scenario "Allow add pictures with create post" do
    login_as(user, :scope => :user)

    visit new_post_path
    fill_in "Title", with: post.title
    fill_in "Body", with: post.body
    #page.attach_file("image", post.image.url)
    #attach_file('image', File.join(Rails.root, '/spec/features/files/donkey.jpg'))
    attach_file("post_image", File.join(Rails.root, '/spec/features/files/donkey.jpg'))
    click_on("Create")

    expect(page).to have_content("Some title")
    expect(page).to have_content("Some body")
    expect(page).to have_css( 'img[src*="donkey.jpg"]' )
  end



end
