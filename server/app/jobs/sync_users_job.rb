class SyncUsersJob < ApplicationJob

  def perform
    User.where(connection_state: 'connected', next_disconnect_date > Time.zone.now).each do |user|
      user.disconnect! if user.conferences.where.not(loop_state: :inactive).length == 0
    end
  end

end