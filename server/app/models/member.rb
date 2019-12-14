class Member < ApplicationRecord

  belongs_to :user
  melongs_to :conference
  
  delegate :phone, to: :user

end
