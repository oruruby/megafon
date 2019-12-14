class ConferencesController < ApplicationController

  before_action :set_conference, only: [:update, :show, :delete]

  def index
    @conferences = Conference.all
  end

  def show

  end

  def create
    @conference = Conference.new(
      name: params[:name],
      user: current_user
    )

    if @conference.save
      #
    else
      #
    end

  end

  def update
    if @conference.update(name: params[:name])
      #
    else
      #
    end
  end

  def delete
    if @conference.destroy
      #
    else
      #
    end
  end

  private

  def set_conference
    @conference = Conference.find(params[:id])
  end

end
