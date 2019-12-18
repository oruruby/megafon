module Member
  class MuteJob
    def perform member
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{member.id}_confConfereeMute",
        method: 'confConfereeMute',
        params: {
          call_session: member.call_session,
        }
      }.to_json), {
        'Content-Type' => 'application/json'
      }
    end
  end
end