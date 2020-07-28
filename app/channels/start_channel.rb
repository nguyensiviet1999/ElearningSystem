class StartChannel < ApplicationCable::Channel
  def subscribed
    stream_from "start"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
