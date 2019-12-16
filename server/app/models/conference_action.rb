class ConferenceAction < ApplicationRecord

  belongs_to :conference
  enum status: [:start, :stop, :activate, :inactivate] 

  validates :status, inclusion: { in: ConferenceAction.statuses.keys }

  after_save :call_action

  private

  def call_action
    conference.send("#{status}!")
  end

end
