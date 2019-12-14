class ConferenceNotifyOfStatusChangedJob < ApplicationJob
  queue_as :default

  def perform(conference)
    ActionCable.server.broadcast 'conference_channel', content: conference 
  end
end
