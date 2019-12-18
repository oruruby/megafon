class User < ApplicationRecord
  include AASM

  has_many :owned_conferences, class_name: 'Conference', foreign_key: :conference_id
  has_many :membered_conferences, through: :members, class_name: 'Conference', foreign_key: :conference_id

  # validates :name, presence: true
  validates :phone, phone: true, uniqueness: true

  aasm(:connection, column: 'connection_state') do 
    state :connected, initial: true
    state :disconnected

    event :connect do
      transitions from: [:disconnected], to: :connected
      after do
        Users::ConnectJob.perform_later self
      end
    end

    event :disconnect do
      transitions from: [:connected], to: :disconnected
      after do
        Users::DisconnectJob.perform_later self
      end
    end
  end

  def key
    Digest::MD5.hexdigest id.to_s
  end

end
