class ConferenceNotifyOfStatusChangedJob < ApplicationJob

  def perform(conference)
    ActionCable.server.broadcast("conference_#{conference.id}", content: present(conference){ |conf|
      type: :conference,
      id: conf.id,
      status: conf.status
    })
  end
  
end