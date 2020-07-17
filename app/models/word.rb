class Word < ApplicationRecord
  belongs_to :course
  validates :course_id, presence: true
  validates :word, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :meaning, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :pronounce, presence: true, length: { maximum: 255 }
  validates :word_type, presence: true, length: { maximum: 255 }
  mount_uploader :image, PictureUploader
end
