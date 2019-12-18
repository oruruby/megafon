module Members
  class CallJob < ApplicationJob
    def perform member
      Net::HTTP.post(URI.parse('http://localhost:5000'), {
        id: "sectetword_#{member.id}_callMake",
        method: 'callMake',
        params: {
         b_numb: member.phone 
        }
      }.to_json, {
        'Content-Type' => 'application/json'
      })
    end
  end
end