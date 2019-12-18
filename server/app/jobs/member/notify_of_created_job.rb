module Member
  class NotifyOfCreatedJob < ApplicationJob

  def perform(member)

    ActionCable.server.broadcast("conference_#{member.conference.id}", content: {
      type: :create_member,
      data: member_json_show
    })
  end
end