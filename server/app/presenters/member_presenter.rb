class MemberPresenter < BasePresenter
  def name
    'Name ' + phone
  end

  def status
    aasm.loop_state
  end

  def mute_status
    aasm.mute_state
  end
end