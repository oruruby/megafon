require "uri"
require "net/http"

class ConferenceStopJob < ApplicationJob
  queue_as :default

  def perform(conference)
    data = { id: "secretworld_#{conference.id}_confDestroy", method: 'confDestroy', params: {
      conf_session: conference.conf_session
    }}
    Net::HTTP.post(URI.parse('http://localhost:5000'), data.to_json, {
      'Content-Type' => 'application/json'
    })
  end

end