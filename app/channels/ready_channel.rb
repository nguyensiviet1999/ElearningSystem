class ReadyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ready"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
