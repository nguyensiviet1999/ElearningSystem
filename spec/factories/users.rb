FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user-name-#{n}" }
    sequence(:email) { |n| "email-#{n}@gmail.com" }
    sequence(:password) { "123456" }
    sequence(:password_confirmation) { "123456" }
    sequence(:activated) { 1 }
  end
end
