module Conference
  class StartJob
    def perform conference
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{conference.id}_confMake",
        method: 'confMake',
      }.to_json), {
        'Content-Type' => 'application/json'
      }
    end
  end
end