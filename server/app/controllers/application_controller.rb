class ApplicationController < ActionController::Base

  include ApplicationHelper

  skip_before_action :verify_authenticity_token

  def current_user
    @current_user ||= User.first
  end

end
