class JoinChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "join_chatroom_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
