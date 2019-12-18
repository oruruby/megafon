module Members
  class CallJob < ApplicationJob
    def perform member
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{member.id}_callTerminate",
        method: 'callTerminate',
        params: {
         b_numb: member.phone 
        }
      }.to_json, {
        'Content-Type' => 'application/json'
      })
    end
  end
end