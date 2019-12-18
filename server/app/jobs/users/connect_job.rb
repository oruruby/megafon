module Users
  class ConnectJob < ApplicationJob
    def perform user
      Net::HTTP.post(URI.parse('http://localhost:5000/connect'), {
        key: user.key,
        token: user.token
      }.to_json, {
        'Content-Type' => 'application/json'
      })
    end
  end
end