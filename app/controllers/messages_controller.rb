class MessagesController < ApplicationController
  def create
    message = Message.new message_params
    message.user = current_user
    if message.save
      ActionCable.server.broadcast "messages",
        message: message.content,
        user: message.user.name,
        id_room: message.chatroom_id,
        root_url: root_url

      head :ok
    else
      redirect_to chatrooms_path
    end
  end

  def show
  end

  private

  def message_params
    params.require(:message).permit(:content, :chatroom_id)
  end
end
