class WordsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @word = Word.new
    @courses = Course.all
    @options_course = Hash.new
    @courses.each do |course|
      @options_course[course.course_name] = course.id
    end
    @options_course
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:success] = "Successfully created..."
      redirect_to new_word_path
    else
      flash[:danger] = "fails created..."
      redirect_to new_word_path
    end
  end

  def edit
  end

  private
  #yêu cầu có :word trong params và chỉ cho phép nhận các param sau
  def word_params
    params.require(:word).permit(:course_id, :word, :pronounce, :word_type, :meaning, :image)
  end
end
