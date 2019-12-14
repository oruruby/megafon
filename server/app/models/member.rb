class Member < ApplicationRecord

  belongs_to :user
  melongs_to :conference
  

end
