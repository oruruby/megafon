class ConferenceActionsController < ApplicationController

  def create
    @conference_action = ConferenceAction.new(
      status: ConferenceAction.statuses[params[:name]].to_i,
      conference: Conference.find(params[:conference_id])
    )
     @conference_action.save
    render json: {status: "success"}
  end

end
