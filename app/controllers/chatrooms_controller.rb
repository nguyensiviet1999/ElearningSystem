class ChatroomsController < ApplicationController
  def new
    @chatroom = Chatroom.new
    @courses = Course.all
    @options_course = Hash.new
    @options_course["All"] = 0
    @courses.each do |course|
      @options_course[course.course_name] = course.id
    end

    @options_course
  end

  def create
    @courses = Course.all
    @options_course = Hash.new
    @options_course["All"] = 0
    @courses.each do |course|
      @options_course[course.course_name] = course.id
    end
    @options_course

    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.user_id = current_user.id
    if @chatroom.save
      flash[:success] = "Successfully created..."
      redirect_to chatrooms_path
    else
      flash[:danger] = "Fail created..."
      render "new"
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def index
    @chatrooms = Chatroom.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    Chatroom.find(params[:id]).destroy
    redirect_to chatrooms_path
  end

  def start
    chatroom = Chatroom.find(params[:id])
    ActionCable.server.broadcast "start",
                                 ready_member: chatroom.join_chatrooms.count(:ready),
                                 member_of_room: chatroom.members.count
    head :ok
  end

  def ready
    chatroom = Chatroom.find(params[:id])
    # chatroom.update_attribute(:number_members, (chatroom.number_members + 1))
    current_user.join_chatrooms.find_by(chatroom_id: chatroom.id).update_attribute(:ready, true)
    ActionCable.server.broadcast "ready",
                                 ready_member: chatroom.join_chatrooms.count(:ready),
                                 member_of_room: chatroom.members.count
    head :ok
  end

  private

  def chatroom_params
    params.require("chatroom").permit(:topic, :course_id, :gold_bet, :number_members, :number_of_words)
  end
end
