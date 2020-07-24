class Word < ApplicationRecord
  has_many :course_words, class_name: "CourseWord", foreign_key: "word_id", dependent: :destroy
  has_many :courses, through: :course_words, source: :course
  validates :word, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :meaning, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :pronounce, presence: true, length: { maximum: 255 }
  validates :word_type, presence: true, length: { maximum: 255 }
  mount_uploader :image, PictureUploader
  # serialize :word, Array
  # has_many :fts_words, dependent: :destroy
  # scope :search, ->(text) {
  #         self.distinct.joins(:fts_words).where("fts_words.title MATCH ?", text)
  #       }

  # def self.build_indexes
  #   values = all.map { |word| build_index(word) }
  #   sql = <<~SQL.strip
  #     INSERT INTO fts_words(word, word_id)
  #     VALUES #{values.join(",")}
  #   SQL
  #   connection.execute(sql)
  # end

  # private

  # def self.build_index(word)
  #   words = word.titles.map { |word_| "(#{connection.quote word_}, #{word.id})" }
  #   (words + ["(#{connection.quote word.title}, #{word.id})"]).join(",")
  # end
end
