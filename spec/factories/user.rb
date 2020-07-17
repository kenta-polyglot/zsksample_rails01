FactoryBot.define do
  factory :user do
    name                  { 'a' * 6 }
    email                 { 'test@example.com' }
  end
end
