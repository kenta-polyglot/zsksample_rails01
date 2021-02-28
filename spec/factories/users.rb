FactoryBot.define do
  factory :user do
    name Faker::Name.name
    sequence(:email) { |n| "tester#{n}@example.com" }
  end
end
