FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence }
    user_id { 1 }
    association :user
  end
end
