class JoinRoomsController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:id])
    if @chatroom.members.count < @chatroom.number_members
      current_user.join_chatrooms.create(chatroom_id: @chatroom.id)
      if current_user.id == @chatroom.user_id
        current_user.join_chatrooms.find_by(chatroom_id: @chatroom.id).update_attribute(:ready, true)
      end
      redirect_to @chatroom
    else
      flash[:danger] = "Room is full..."
      redirect_to chatrooms_path
    end
  end

  def destroy
    @chatroom = Chatroom.find(params[:id])
    current_user.join_chatrooms.find_by(chatroom_id: @chatroom.id).destroy
    # @chatroom.update_attribute(:number_members, (@chatroom.number_members - 1))
    redirect_to chatrooms_path
  end
end
