FactoryGirl.define do
  factory :comment do
    body "Some comment body"
    user
    post
  end
end
