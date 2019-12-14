class User < ApplicationRecord

  has_many :owned_conferences, class_name: 'Conference', foreign_key: :conference_id
  has_many :membered_conferences, through: :members, class_name: 'Conference', foreign_key: :conference_id

  validates :name, presence: true
  validates :phone, phone: true

  validates :megafone_login
  validates :megafone_password

end
