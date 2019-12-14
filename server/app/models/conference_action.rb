class ConferenceAction < ApplicationRecord

  belongs_to :conference

  validates :name, inclusion: { in: names.keys }
  
  as_enum :name, run: 1, stop: 2 

  after_save :call_action

  private

  def call_action
    if run?
      conference.start
    elsif stop?
      conference.stop
    end
  end

end
