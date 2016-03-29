FactoryGirl.define do
  factory :post do
    title "Some title"
    body "Some body"
    user
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/features/files/donkey.jpg')))
    #image File.join(Rails.root, '/spec/features/files/donkey.jpg')
  end
end
