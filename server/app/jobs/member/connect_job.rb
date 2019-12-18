module Member
  class ConnectJob
    def perform member
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{member.id}_confAdd",
        method: 'confAdd',
        params: {
          call_session: member.call_session,
          conf_session: member.conference.conf_session
        }
      }.to_json), {
        'Content-Type' => 'application/json'
      }
    end
  end
end