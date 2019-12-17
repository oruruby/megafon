class MemberActionsController < ApplicationController

  def create
    Member.find(params[:member_id]).actions.create(status: params[:name])
    render json: {status: "success"}
  end

end
