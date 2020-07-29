class FinishedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "finished"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
