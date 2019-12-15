class ConferenceAction < ApplicationRecord

  belongs_to :conference
  enum status: [:run, :stop] 

  validates :status, inclusion: { in: ConferenceAction.statuses.keys }
  

  after_save :call_action

  private

  def call_action
    if status == "run"
      conference.start!
    elsif status == "stop"
      conference.stop!
    end
  end

end
