require "uri"
require "net/http"

class ApplicationJob < ActiveJob::Base
  queue_as :default
end
