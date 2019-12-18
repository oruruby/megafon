module Conference
  class NotifyOfUpdatedJob < ApplicationJob
    def perform(member)
      ActionCable.server.broadcast("conference_#{conference.id}", content: {
        type: :update,
        data: conference_json_show
      })
    end
  end
end