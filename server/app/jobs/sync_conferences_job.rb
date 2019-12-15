class SyncConferencesJob < ApplicationJob
  queue_as :default

  def perform
    Conference.where(aasm_state: 'pending').each do |conference|
      if conference.conf_session
        CheckConferenceJob.perform_later conference
      else
        conference.inactivate!
      end
    end
  end

end