class CoursesController < ApplicationController
  def show
    @course = Course.find(params[:id])
    @learning_words = @course.words.paginate(page: params[:page])
    puts @learning_words.inspect
  end

  def new
    @course = Course.new
    @categories = Category.all
    @options_category = Hash.new
    @categories.each do |category|
      @options_category[category.name_category] = category.id
    end
    @options_category
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "them thanh cong"
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def words_of_course
    @course = Course.find(params[:id])
    @words_of_course = @course.words
  end

  def learn
    @course = Course.find(params[:course_id])
    @current_word = Word.find(params[:word_id]).blank? ? 0 : Word.find(params[:word_id])
    @learning_words = @course.words
    puts @current_word.inspect
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :category_id, :image)
  end
end
