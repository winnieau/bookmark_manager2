
FactoryGirl.define do
  factory :user do
    email "alice@example.com"
    password "oranges!"
    password_confirmation "oranges!"
  end
end