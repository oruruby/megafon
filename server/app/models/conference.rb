class Conference < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :members
  has_many :actions, class_name: 'ConferenceAction'

  validates :name, presence: true

  aasm do
    state :inactive, initial: true
    state :active
    state :pending
    state :checking

    event :start, after: :start_event do
      transitions from: [:inactive], to: :pending
    end

    event :check, after: :check_event do 
      transitions from: [:active, :pending], to: :checking
    end
    
    event :stop, after: :stop_event do
      transitions from: [:active], to: :pending
    end
  
    event :activate, after: :activate_event do 
      transitions from: [:checking, :pending], to: :active
    end

    event :inactivate, after: :incativate_event do 
      transitions from: [:checking, :pending], to: :inactive
    end
  end

  private

  def check_event
    notify_of_status_changed
    check_conference
  end

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

  def check_conference
    ConferenceCheckJob.perform_later self
  end

  def stop_conference
    ConferenceStopJob.perform_later self
  end

  def start_conference
    ConferenceStartJob.perform_later self
  end

end
