class ConferenceActionsController < ApplicationController

  def create
    Conference.find(params[:conference_id]).actions.create(status: params[:name].to_i)
    render json: {status: "success"}
  end

end
