class Member < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :conference

  has_many :actions, class_name: 'MemberAction'
  
  delegate :phone, to: :user

  after_update do
    Member::NotifyOfUpdatedJob.perform_later self
  end

  after_destroy do
    Member::NotifyOfDestroyedJob.perform_later self
  end

  after_create do
    Member::NotifyOfCreatedJob.perform_later self
  end

  validate :inclusion_user_in_conference

  aasm(:mute, column: 'mute_state') do 
    state :not_in_mute, initial: true
    state :muting
    state :in_mute
    state :unmuting

    #

    event :mute do 
      transitions from: [:not_in_mute], to: :muting
      after do 
        Member::MuteJob.perform_later self
      end
    end

    event :unmute do
      transitions from: [:in_mute], to: :unmuting
      after do 
        Member::UnmuteJob.perform_later self
      end
    end

    #

    event :success_muting do
      transitions from: [:muting], to: :in_mute
    end

    event :success_unmuting do 
      transitions from: [:unmuting], to: :not_in_mute
    end

    #

    event :failure_muting do 
      transitions from: [:muting], to: :not_in_mute
    end

    event :failure_unmuting do 
      transitions from: [:unmuting], to: :in_mute
    end
  end

  aasm(:loop, column: 'loop_state') do
    state :disconnected, initial: true
    state :calling, :in_call, :connecting, :in_conf, :disconnecting

    event :call do 
      transitions from: [:disconnected], to: :calling
      after do 
        Member::CallJob.perform_later self
      end
    end

    event :connect do
      transitions from: [:in_call], to: :connecting
      after do 
        Member::ConnectJob.perform_later self
      end
    end

    event :disconnect do 
      transitions from: [:in_conf], to: :disconnecting
      after do 
        Member::DisconnectJon.perform_later self
      end
    end

    #

    event :success_calling do 
      transitions from: [:calling], to: :in_call

      after do
        connect!
      end
    end

    event :success_connecting do 
      transitions from: [:connecting], to: :in_conf
    end

    event :success_disconnecting do 
      transitions from: [:disconnecting], to: :disconnected
      after do
        call_session = nil
      end
    end

    #

    event :failure_calling do 
      transitions from: [:calling], to: :disconnected
    end

    event :failure_connecting do 
      transitions from: [:connecting], to: :disconnecting
      after do 
        Member::TerminateCallJob.perform_later self
      end
    end

    #

    event :reject_call do 
      transitions from: [:calling, :in_call, :connecting, :in_conf, :disconnecting], to: :disconnected
      after do 
        call_session = nil
      end
    end 
    

  end

  private

  def inclusion_user_in_conference
    errors.add(:user, "already in conference") if Member.where(user: user, conference: conference).where.not(id: id)[0].present?
  end

end
