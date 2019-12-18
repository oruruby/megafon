require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options, :delete, :patch]
      end
    end
  end
end
