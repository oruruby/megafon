class Conference < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :members
  has_many :actions, class_name: 'ConferenceAction'

  validates :name, presence: true, uniqueness: true

  after_update do 
    ActionCable.server.broadcast("conference_#{id}", content: {
      type: :update,
      data: conference_json_show(self)
    })
    ActionCable.server.broadcast("user_#{user.id}", content: {
      type: :update_conference,
      data: conference_json_show(self)
    })
  end

  after_destroy do
    ActionCable.server.broadcast("user_#{user.id}", content: {
      type: :delete_conference,
      data: conference_json_show(self)
    })
  end

  after_create do
    ActionCable.server.broadcast("conference_#{id}", content: {
      type: :create,
      data: conference_json_show(self)
    })
    ActionCable.server.broadcast("user_#{user.id}", content: {
      type: :create_conference,
      data: conference_json_show(self)
    })
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
        Conferences::StartJob.perform_later self
      end
    end

    event :check do 
      transitions from: [:active, :pending], to: :checking
      after do
        Conferences::CheckJob.perform_later self
      end
    end
    
    event :stop do
      transitions from: [:active], to: :pending
      after do
        Conferences::StopJob.perform_later self
      end
    end
  
    event :activate do 
      transitions from: [:checking, :pending], to: :active
      after do
        members.each(&:call!)
      end
    end

    event :inactivate do 
      transitions from: [:checking, :pending], to: :inactive
    end
  end

end
