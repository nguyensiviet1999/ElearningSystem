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
    @chatroom = Chatroom.new()
  end

  def show
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @message = Message.new
    @chatroom.update_attributes(number_members: (@chatroom.number_members + 1))
  end

  def index
    @chatrooms = Chatroom.paginate(page: params[:page], per_page: 5)
  end

  private

  def chatroom_params
    params.require("chatroom").permit(:topic, :course_id, :gold_bet, :number_members, :number_of_words)
  end
end
