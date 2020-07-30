class CheckRoomStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "check_room_status"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
