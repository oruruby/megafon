class ConferenceActionsController < ApplicationController

  def create
    @conference_action = ConferenceAction.new(
      name: ConferenceAction.names[params[:name]]
    )

    if @conference_action.save
      #
    else
      #
    end
  end

end
