class Course < ApplicationRecord
  has_one :category
  has_many :results, class_name: "Result", foreign_key: "course_id", dependent: :destroy
  has_many :users, through: :results, source: :user
  has_many :course_words, class_name: "CourseWord", foreign_key: "course_id", dependent: :destroy
  has_many :words, through: :course_words, source: :word
  mount_uploader :image, PictureUploader
  validates :course_name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  validates :category_id, presence: true
end
