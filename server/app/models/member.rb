class Member < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :conference

  has_many :actions, class_name: 'MemberAction'
  
  delegate :phone, to: :user

  after_commit :notify_of_status_changed

  validate :inclusion_user_in_conference

  aasm do
    state :inactive, initial: true
    state :calling
    state :connecting
    state :disconnecting
    state :active

    event :call, after_commit: :call_event do 
      transitions from: [:inactive], to: :calling
    end

    event :connect, after_commit: :connect_event do 
      transitions from: [:calling], to: :connecting
    end

    event :activate do 
      transitions from: [:connecting], to: :active
    end

    event :inactivate do 
      transitions from: [:active, :disconnecting], to: :inactive
    end

    event :disconnect, after_commit: :disconnect_event do 
      transitions from: [:active], to: :disconnecting
    end

  end

  private

  def call_event
    call_member
  end

  def connect_event
    connect_member
  end

  def disconnect_event
    disconnect_member
  end

  def call_member
    MemberCallJob.perform_later self.reload
  end

  def connect_member
    MemberConnectJob.perform_later self.reload
  end

  def disconnect_member
    MemberDisconnectJob.perform_later self.reload
  end

  def notify_of_status_changed
    MemberNotifyOfStatusChangedJob.perform_later self
  end

  def inclusion_user_in_conference
    errors.add(:user, "already in conference") if Member.where(user: user, conference: conference).where.not(id: id)[0].present?
  end

end
