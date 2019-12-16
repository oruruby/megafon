class MemberNotifyOfStatusChangedJob < ApplicationJob

  def perform(member)
    ActionCable.server.broadcast("conference_#{member.conference.id}", content: present(member){ |memb|
      type: :member,
      id: memb.id,
      status: memb.status
    })
  end
