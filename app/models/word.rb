class Word < ApplicationRecord
  has_many :course_words, class_name: "CourseWord", foreign_key: "word_id", dependent: :destroy
  has_many :courses, through: :course_words, source: :course
  validates :word, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :meaning, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :pronounce, presence: true, length: { maximum: 255 }
  validates :word_type, presence: true, length: { maximum: 255 }
  mount_uploader :image, PictureUploader
end
