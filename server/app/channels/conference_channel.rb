class ConferenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conference_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end