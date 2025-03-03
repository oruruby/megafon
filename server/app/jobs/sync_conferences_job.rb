class SyncConferencesJob < ApplicationJob

  def perform
    Conference.where(loop_state: 'pending').each do |conference|
      if conference.conf_session
        conference.check!
      else
        conference.actions.inactivate!
      end
    end
  end

end