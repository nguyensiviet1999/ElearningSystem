class CourseWordsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @words = Word.all
    # @words = Word.where.not(id: @course.words.ids)
    @pagy_a, @words = pagy_array(@words, items: 4)
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

  def delete
    @course = Course.find(params[:course_id])
    @words = @course.words
    @pagy_a, @words = pagy_array(@words, items: 4)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @word_id = params[:word_id]

    if @course.course_words.find_by(word_id: @word_id).destroy
      @des_success = true
      respond_to do |format|
        format.js
      end
    else
      @des_success = false
      respond_to do |format|
        format.js
      end
    end
  end
end
