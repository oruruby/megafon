class MemberPresenter < BasePresenter
  def name
    'Name ' + phone
  end

  def status
    aasm.current_state
  end
end