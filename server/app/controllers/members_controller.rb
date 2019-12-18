class MembersController < ApplicationController

  before_action :set_member, only: [:destroy]

  def create
    @user = User.find_or_create_by(phone: params[:phone])
    if @user.valid?
      @member = Member.new(user: @user, conference: Conference.find(params[:conference_id]) )
      if @member.save
        # ActionCable.server.broadcast "conference_#{@member.conference_id}", content: conference_json_show(@member.conference) 
        render json: {status: 'success'}
      else
        render json:{ errors: @member.errors }
      end
    else
      render json:{ errors: @user.errors }
    end
  end

  def destroy
    @member.destroy!
    render json: {status: 'success'}
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

end
