class ApplicationController < ActionController::Base

  include ApplicationHelper

  skip_before_action :verify_authenticity_token
  before_action :update_disconnect_time

  def current_user
    @current_user ||= User.first
  end

  def update_disconnect_time
    current_user.connect! if current_user.disconnected?
    current_user.next_disconnect_date = 30.minutes.ago
    current_user.save
  end

end
