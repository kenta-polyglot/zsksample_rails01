FactoryBot.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.free_email
  end
end
