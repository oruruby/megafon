module Member
  class UnmuteJob
    def perform member
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{member.id}_confConfereeUnmute",
        method: 'confConfereeUnmute',
        params: {
          call_session: member.call_session,
        }
      }.to_json), {
        'Content-Type' => 'application/json'
      }
    end
  end
end