module Member
  class NotifyOfDestroyedJob < ApplicationJob

  def perform(member)

    ActionCable.server.broadcast("conference_#{member.conference.id}", content: {
      type: :destroy_member,
      data: member_json_show
    })
  end
end