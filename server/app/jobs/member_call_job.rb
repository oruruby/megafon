class MemberCallJob < ApplicationJob

  def perform(member)
    data = { id: "secretworld_#{member.id}_callMake", method: 'callMake', params: {
      b_numb: member.phone
    }}
    Net::HTTP.post(URI.parse('http://localhost:5000'), data.to_json, {
      'Content-Type' => 'application/json'
    })
  end

end