module Conference
  class StopJob
    def perform conference
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{conference.id}_confDestroy",
        method: 'confDestroy',
        params: {
          conf_session: conference.conf_session
        }
      }.to_json), {
        'Content-Type' => 'application/json'
      }
    end
  end
end