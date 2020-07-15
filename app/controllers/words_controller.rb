class WordsController < ApplicationController
  def index
    @words = Word.all.paginate(page: params[:page], per_page: 10)
    @courses = Course.all
    @options_course = Hash.new
    @options_course["All"] = 0
    @courses.each do |course|
      @options_course[course.course_name] = course.id
    end

    @options_course
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

  def search_word
    order = params[:order] if params[:order].present?
    search = params[:search] if params[:search].present?
    if params[:learning_status].present?
      if params[:course_id].present? && params[:course_id] != 0
        @words = current_user.learned_words_of_course(params[:course_id])
      end
    else
      if params[:course_id].present? && params[:course_id] != 0
        @course = Course.find(params[:course_id])
        @words = @course.words.order(word: :desc)
      else
        @words = Word.order(word: :desc)
      end
    end

    render @words
  end

  private

  #yêu cầu có :word trong params và chỉ cho phép nhận các param sau
  def word_params
    params.require(:word).permit(:course_id, :word, :pronounce, :word_type, :meaning, :image)
  end
end
