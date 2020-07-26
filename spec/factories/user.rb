FactoryBot.define do

  factory :user do
    name { 'test' }
    email { 'test@example.com' }
  end

  factory :test1, class: User do
    name { 'test1' }
    email { 'test1@example.com' }
  end
end
