class ChatroomsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

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
    if Chatroom.find(params[:id]).destroy
      ActionCable.server.broadcast "delete_room",
                                   root_url: root_url,
                                   id_room: params[:id]
      head :ok
    end
  end

  def start
    chatroom = Chatroom.find(params[:id])
    chatroom.update_attribute(:started, true)
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

  def render_match
    @chatroom = Chatroom.find(params[:id])
    @current_word = Course.find(@chatroom.course_id).words.first
    @exam_words = []
    number_of_words = Course.find(@chatroom.course_id).words.count > @chatroom.number_of_words ? @chatroom.number_of_words : Course.find(@chatroom.course_id).words.count
    all_words_of_course = Course.find(@chatroom.course_id).words.limit(number_of_words)
    index = 0
    index_current_word = 0
    all_words_of_course.each { |word|
      index_current_word = index if word == @current_word
      answer = Array.new
      shuffle_all_words = Word.limit(20).shuffle
      4.times { |i|
        if (shuffle_all_words[i].meaning != word.meaning)
          answer.push(shuffle_all_words[i].meaning)
        end
        break if (answer.length == 3)
      }
      answer.push(word.meaning)
      @exam_words.push({ :word => word, :answer => answer.shuffle! })
      index = index + 1
    }

    @exam_words[0], @exam_words[index_current_word] = @exam_words[index_current_word], @exam_words[0]
    @exam_words[1..(@exam_words.length - 1)].shuffle!
    respond_to do |format|
      format.html { }
      format.js
    end
    # puts @exam_words
  end

  def finished
    ActionCable.server.broadcast "finished",
                                 winner_id: current_user.id
    head :ok
  end

  def check_room_status
    chatroom = Chatroom.find(params[:id])

    ActionCable.server.broadcast "check_room_status",
                                 title: current_user.name,
                                 avatar: current_user.avatar.url,
                                 link_to: "/users/" + current_user.id.to_s,
                                 ready_member: chatroom.join_chatrooms.count(:ready),
                                 member_of_room: chatroom.members.count,
                                 max_number_members: chatroom.number_members

    head :ok
  end

  private

  def chatroom_params
    params.require("chatroom").permit(:topic, :course_id, :gold_bet, :number_members, :number_of_words)
  end
end
