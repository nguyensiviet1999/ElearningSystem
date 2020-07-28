class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  mount_uploader :avatar, PictureUploader
  has_many :results, class_name: "Result", foreign_key: "user_id", dependent: :destroy
  has_many :courses, through: :results, source: :course
  has_many :user_learned_words, class_name: "UserLearnedWord", foreign_key: "user_id", dependent: :destroy
  has_many :learned_words, through: :user_learned_words, source: :word

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :messages, class_name: "Message", foreign_key: "user_id", dependent: :destroy
  has_many :notifications, as: :recipient
  has_many :host_chatrooms, class_name: "Chatroom", foreign_key: "user_id", dependent: :destroy
  has_many :join_chatrooms, class_name: "JoinRoom", foreign_key: "user_id", dependent: :destroy
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { maximum: 50 }
  validate :picture_size

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  #user tham gia khoá học
  def join_to_course(course)
    results.create(course_id: course.id)
  end

  #user huỷ tham gia khoá học
  def leave_to_course(course)
    results.find_by(course_id: course.id).destroy
  end

  #check xem user có join khoá học hay chưa
  def joined_course?(course)
    courses.include?(course)
  end

  def learned_word(word)
    user_learned_words.create(word_id: word.id)
  end

  def unlearned_word(word)
    user_learned_words.find_by(word_id: word.id).destroy
  end

  def learned_words_of_course(course_id)
    learned_words_of_course = Course.find(course_id).words && learned_words
    return learned_words_of_course
  end

  def words_not_learned(course_id)
    words_not_learned = []
    if (course_id == 0)
      words_not_learned = Word.where.not(id: learned_words.ids)
    else
      Course.find(course_id).words.each do |word|
        words_not_learned.push(word) if !learned_words_of_course(course_id).include?(word)
      end
    end
    return words_not_learned
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private

  # Converts email to all lowercase.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  # Validates the size of an uploaded picture.
  def picture_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
