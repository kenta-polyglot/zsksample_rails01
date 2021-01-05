FactoryBot.define do
  factory :micropost do
    association :user
    content { Faker::Lorem.sentence }
  end
end
