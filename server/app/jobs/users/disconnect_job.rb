module Users
  class DisonnectJob < ApplicationJob
    def perform user
      Net::HTTP.post(URI.parse('http://localhost:5000/disconnect'), {
        key: user.key
      }.to_json, {
        'Content-Type' => 'application/json'
      })
    end
  end
end