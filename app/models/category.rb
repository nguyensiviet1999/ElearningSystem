class Category < ApplicationRecord
  validates :name_category, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  has_many :courses, class_name: "Course", foreign_key: "category_id"
end
