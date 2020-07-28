class Chatroom < ApplicationRecord
  attr_accessor :current_number_person
  has_many :messages, class_name: "Message", foreign_key: "chatroom_id", dependent: :destroy
  belongs_to :host, class_name: "User", foreign_key: "user_id"
  has_many :join_chatrooms, class_name: "JoinRoom", foreign_key: "chatroom_id", dependent: :destroy
  has_many :members, through: :join_chatrooms, source: :user

  def set_default
    current_number_person = 0
  end
end
