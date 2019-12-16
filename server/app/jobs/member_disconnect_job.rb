class MemberDisconnectJob < ApplicationJob

  def perform(member)
    data = { id: "secretworld_#{member.id}_confRemove", method: 'confRemove', params: {
      call_session: member.call_session,
      conf_session: member.conference.conf_session
    }}
    Net::HTTP.post(URI.parse('http://localhost:5000'), data.to_json, {
      'Content-Type' => 'application/json'
    })
  end

end