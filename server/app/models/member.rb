class Member < ApplicationRecord

  belongs_to :user
  belongs_to :conference
  
  delegate :phone, to: :user

  validate :inclusion_user_in_conference

  private

  def inclusion_user_in_conference
    errors.add(:user, "already in conference") if Member.where(user: user, conference: conference)[0].present?
  end

end
