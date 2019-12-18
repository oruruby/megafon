class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{params[:room]}" if true #TODO: Decline if not owned conference
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end