class ConferenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conference_#{params[:room]}" if true #TODO: Decline if not owned conference
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end