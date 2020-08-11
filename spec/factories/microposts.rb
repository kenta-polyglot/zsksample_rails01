FactoryBot.define do
  factory :sample, class: Micropost do
    user_id { 1 }
    content { 'test' }
  end
  factory :example, class: Micropost do
    user_id { 2 }
    content { 'sample' }
  end

  factory :micropost do
    content { 'sample content' }
    association :user

    trait :over_140 do
      content { 'a' * 141 }
    end
    trait :just_140 do
      content { 'a' * 140 }
    end
    trait :below_140 do
      content { 'a' * 139 }
    end
  end
end
