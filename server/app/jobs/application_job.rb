require "uri"
require "net/http"

class ApplicationJob < ActiveJob::Base

  include ApplicationHelper

  queue_as :default

  def present(model)
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end
  
end
