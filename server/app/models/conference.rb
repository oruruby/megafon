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
    
    event :stop do
      transitions from: [:active], to: :inactive
    end
  
    event :activate, after: :notify_activation do 
      transitions from: [:pending], to: :active
    end
  end

  private

  def start_event
    notify_of_status_changed
    connect_members
  end

  def stop_event
    notify_of_status_changed
  end

  def activate_event
    notify_of_status_changed
  end

  def notify_of_status_changed
    ConferenceNotiFyOfStatusChanged.perform_later self
  end

  def connect_members
    StartConference.perform_later self
  end

end
