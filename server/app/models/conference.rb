class Conference < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :members
  has_many :actions, class_name: 'ConferenceAction'

  after_update do 
    Conference::NotifyOfUpdatedJob.perform_later self
  end

  validates :name, presence: true

  aasm do
    state :inactive, initial: true
    state :active
    state :pending
    state :checking

    event :start do
      transitions from: [:inactive], to: :pending
      after do
        Conference::StartJob.perform_later self
      end
    end

    event :check do 
      transitions from: [:active, :pending], to: :checking
      after do
        Conference::CheckJob.perform_later self
      end
    end
    
    event :stop do
      transitions from: [:active], to: :pending
      after do
        Conference::StopJob.perform_later self
      end
    end
  
    event :activate do 
      transitions from: [:checking, :pending], to: :active
    end

    event :inactivate do 
      transitions from: [:checking, :pending], to: :inactive
    end
  end

end
