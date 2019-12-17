class MemberNotifyOfStatusChangedJob < ApplicationJob

  def perform(member)
    content = begin
      present(member) do |memb|
        puts memb.status
        {
          type: :member,
          id: memb.id,
          status: memb.status
        }
      end
    end

    ActionCable.server.broadcast("conference_#{member.conference.id}", content: content)
  end
end