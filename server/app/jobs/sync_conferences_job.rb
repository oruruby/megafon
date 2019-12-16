class SyncConferencesJob < ApplicationJob

  def perform
    Conference.where(aasm_state: 'pending').each do |conference|
      if conference.conf_session
        conference.actions.create(status: :check)
      else
        conference.actions.create(status: :inactivate)
      end
    end
  end

end