class Member < ApplicationRecord

  belongs_to :user
  belongs_to :conference

  has_many :actions, class_name: 'MemberAction'
  
  delegate :phone, to: :user

  validate :inclusion_user_in_conference

  aasm do
    state :inactive, initial: true
    state :calling
    state :connecting
    state :disconnecting
    state :active

    event :call, after: :call_event do 
      transitions from: [:inactive], to: :calling
    end

    event :connect, after: :connect_event do 
      transitions from: [:inactive], to: :connecting
    end

    event :activate, after: :activate_event do 
      transitions from: [:inactive], to: :active
    end

    event :inactivate, after: :inactivate_event do 
      transitions from: [:active, :disconnecting], to: :inactive
    end

    event :disconnect, after: :disconnect_event do 
      transitions from: [:active], to: :disconnecting
    end

  end

  private

  def call_event
    notify_of_status_changed
    call_member
  end

  def connect_event
    notify_of_status_changed
    connect_member
  end

  def activate_event
    notify_of_status_changed
  end

  def inactivate_event
    notify_of_status_changed
  end

  def disconnect_event
    notify_of_status_changed
    disconnect_member
  end

  def call_member
    MemberCallJob.perform_later self
  end

  def connect_member
    MemberConnectJob.perform_later self
  end

  def disconnect_member
    MemberDisconnectJob.perform_later self
  end

  def notify_of_status_changed
    MemberNotifyOfStatusChangedJob.perform_later self
  end

  def inclusion_user_in_conference
    errors.add(:user, "already in conference") if Member.where(user: user, conference: conference)[0].present?
  end

end
