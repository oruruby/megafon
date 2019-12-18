class ConferencesController < ApplicationController

  before_action :set_conference, only: [:update, :show, :destroy]

  def index
    @conferences = Conference.all
    render json: helpers.conference_json_index(@conferences)
  end

  def show
    render json: helpers.conference_json_show(@conference)
  end

  def create
    @conference = Conference.new(
      name: params[:name],
      user: current_user
    )
    if @conference.save
      render json: {status: :success}
    else
      render json:{ errors: @conference.errors }
    end

  end

  def update
    if @conference.update(name: params[:name])
      #
    else
      #
    end
  end

  def destroy
    @conference.destroy
    render json: {status: :success}
  end

  private

  def set_conference
    @conference = Conference.find(params[:id])
  end

end
