class Conference < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :members


  validates :name, presence: true

  aasm do
    state :inactive, initial: true
    state :active
    state :pending
  end

  event :start, after: :start_event do
    transitions from: [:inactive], to: :pending
  end    
  
  event :stop do
    transitions from: [:active], to: :pending
  end

  event :activate, after: :notify_activation do 
    transitins from: [:pending], to: :active
  end

  event :deactivate, after: :notify_deactivation do 
    transitins from: [:pending], to: :deactivate
  end

  private

  def start_event
    notify_of_status_changed
    connect_members
  end

  def stop_event
    notify_of_status_changed
    disconect_members
  end

  def activate_event
    notify_of_status_changed
  end

  def deactivate_event
    notify_of_status_changed
  end

  def notify_of_status_changed
    ConferenceNotiFyOfStatusChanged.perform_later self
  end

  def connect_members
    ConferenceConnectMembers.perform_later self
  end

  def disconect_members
    ConferenceDisconectMembers.perform_later self
  end

end
