class CourseWord < ApplicationRecord
  belongs_to :word
  belongs_to :course
  validates :word_id, presence: true
  validates :course_id, presence: true
end
