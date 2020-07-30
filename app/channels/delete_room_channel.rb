class DeleteRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "delete_room"
  end

  def unsubscribed
    stop_all_streams
  end
end
