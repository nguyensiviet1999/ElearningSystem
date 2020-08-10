FactoryBot.define do
  factory :course do
    sequence(:course_name) { |n| "course-name-#{n}" }
    association :category
  end
end
