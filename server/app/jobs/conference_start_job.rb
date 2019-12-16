class ConferenceStartJob < ApplicationJob

  def perform(conference)
    data = { id: "secretworld_#{conference.id}_confMake", method: 'confMake'}
    Net::HTTP.post(URI.parse('http://localhost:5000'), data.to_json, {
      'Content-Type' => 'application/json'
    })
  end

end