FactoryBot.define do
  factory :user do
    name                  { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    trait :invalid do
      name          { '' }
      email         { '' }
    end
  end
end
