class MemberAction < ApplicationRecord

  belongs_to :member
  enum status: [:call, :connect, :activate, :inactivate, :disconnect] 

  validates :status, inclusion: { in: MemberAction.statuses.keys }

  after_save :call_action

  private

  def call_action
    member.send("#{status}!")
  end

end