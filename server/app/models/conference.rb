class Conference < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :members


  validates :name, presence: true

  aasm do
    state :inactive, initial: true
    state :active
    state :pending

    event :start, after: :start_event do
      transitions from: [:inactive], to: :pending
    end    
    
    event :stop, after: :stop_event do
      transitions from: [:active], to: :pending
    end
  
    event :activate, after: :activate_event do 
      transitions from: [:pending], to: :active
    end

    event :inactivate, after: :incativate_event do 
      transitions from: [:pending], to: :inactive
    end
  end

  private

  def start_event
    notify_of_status_changed
    start_conference
  end

  def stop_event
    stop_conference
    notify_of_status_changed
  end

  def activate_event
    notify_of_status_changed
  end

  def incativate_event
    notify_of_status_changed
  end

  def notify_of_status_changed
    ConferenceNotifyOfStatusChangedJob.perform_later self
  end

  def stop_conference
    StopConferenceJob.perform_later self
  end

  def start_conference
    StartConferenceJob.perform_later self
  end

end
