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
    @course = Course.find(params[:id])
    @current_word = params[:word_id].blank? ? @course.words.first : Word.find(params[:word_id])
    @learning_words = @course.words
    puts @current_word.inspect
  end

  def examination
    @current_word = Word.find(params[:current_word_id])
    @exam_words = []
    all_words_of_course = @current_word.course.words
    all_words_of_course.each { |word|
      answer = Array.new
      shuffle_all_words = Word.all.shuffle
      4.times { |i|
        if (shuffle_all_words[i].meaning != word.meaning)
          answer.push(shuffle_all_words[i].meaning)
        end
        break if (answer.length == 3)
      }
      answer.push(word.meaning)
      @exam_words.push({ :word => word, :answer => answer.shuffle! })
      break if word == @current_word
    }
    @exam_words.shuffle!
    puts @exam_words
  end

  def new_release
    respond_to do |format|
      format.html
      format.js
    end
  end

  def check_answer
    answer = params[:answer]
    word = Word.find(params[:word_id])
    @answer_at = params[:answer_at]
    @correct_answer = true
    if (answer == word.meaning)
      @correct_answer = true
      respond_to do |format|
        format.js
      end
      if !current_user.learned_words.include?(word)
        current_user.learned_word(word)
      end
    else
      @correct_answer = false
      respond_to do |format|
        format.js
      end
      if current_user.learned_words.include?(word)
        current_user.unlearned_word(word)
      end
    end
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :category_id, :image)
  end
end
