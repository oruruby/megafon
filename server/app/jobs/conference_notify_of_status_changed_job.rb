class ConferenceNotifyOfStatusChangedJob < ApplicationJob

  def perform(conference)
    ActionCable.server.broadcast "conference_#{conference.id}", content: 'update' 
  end
  
end
