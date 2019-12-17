class ConferencePresenter < BasePresenter

  def message
    'через 2 часа'
  end

  def counter
    '0/15'
  end

  def status
    aasm.current_state
  end
end