class CourseWordsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @words = Word.all
  end

  def create
    @course = Course.find(params[:course_id])
    @word_id = params[:word_id]
    if @course.course_words.create(word_id: params[:word_id])
      @success = true
      respond_to do |format|
        format.js
      end
    else
      @success = false
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
  end
end
