class RoomsController < ApplicationController

  def index
    @current_user = current_user
    return redirect_to '/signin' unless @current_user
    # @users = User.all
    room_name = "private_#{@current_user.id}_room"
    @group_room = Game.first.public_room
    @private_room = @current_user.private_room
  end

  # def create
  #   @room = Room.create(name: params["room"]["name"])
  # end

  # def show
  #   @current_user = current_user
  #   @single_room = Room.find(params[:id])
  #   @room = Room.new
  #   @message = Message.new
  #   @messages = @single_room.messages
  # end
end