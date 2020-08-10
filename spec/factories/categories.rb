FactoryBot.define do
  factory :category do
    sequence(:name_category) { |n| "category-name-#{n}" }
  end
end
