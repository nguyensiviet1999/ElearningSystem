class Chatroom < ApplicationRecord
  attr_accessor :current_number_person
  has_many :messages, class_name: "Message", foreign_key: "chatroom_id", dependent: :destroy
  belongs_to :users

  def set_default
    current_number_person = 0
  end
end
