module Member
  class NotifyOfUpdatedJob < ApplicationJob

  def perform(member)

    ActionCable.server.broadcast("conference_#{member.conference.id}", content: {
      type: :update_member,
      data: member_json_show
    })
  end
end