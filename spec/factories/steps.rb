# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :step do
    name "MyString"
    description "MyText"

    association :journey, strategy: :build
  end
end
