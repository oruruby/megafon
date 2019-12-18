class MemberPresenter < BasePresenter
  def name
    'Name ' + phone
  end

  def status
    aasm(:loop).current_state
  end

  def mute_status
    aasm(:mute).current_state
  end
end