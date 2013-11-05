FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com"}
    password '0000'
    password_confirmation '0000'
    name 'factory girl'
  end
end