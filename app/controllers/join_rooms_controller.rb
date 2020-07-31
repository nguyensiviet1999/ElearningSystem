class JoinRoomsController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:id])
    if ((@chatroom.members.count < @chatroom.number_members) && !@chatroom.started?)
      current_user.join_chatrooms.create(chatroom_id: @chatroom.id)
      if current_user.id == @chatroom.user_id
        current_user.join_chatrooms.find_by(chatroom_id: @chatroom.id).update_attribute(:ready, true)
      end
      redirect_to @chatroom
    else
      flash[:danger] = "Room is full...or Started"
      redirect_to chatrooms_path
    end
  end

  def destroy
    @chatroom = Chatroom.find(params[:id])
    current_user.join_chatrooms.find_by(chatroom_id: @chatroom.id).destroy if current_user.join_chatrooms.find_by(chatroom_id: @chatroom.id).present?
    ActionCable.server.broadcast "leave",
                                 chatroom_id: @chatroom.id,
                                 user_id: current_user.id,
                                 root_url: root_url,
                                 member_of_room: @chatroom.members.count,
                                 max_member: @chatroom.number_members,
                                 ready_member: @chatroom.join_chatrooms.count(:ready),
                                 is_started: @chatroom.started?
    head :ok
  end
end
