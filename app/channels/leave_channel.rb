class LeaveChannel < ApplicationCable::Channel
  def subscribed
    stream_from "leave"
  end

  def unsubscribed
    stop_all_streams
  end
end
