class ConferenceNotifyOfStatusChangedJob < ApplicationJob
  queue_as :default

  def perform(conference)
    ActionCable.server.broadcast "conference_#{conference.id}", content: 'update' 
  end
end
