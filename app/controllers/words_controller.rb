class WordsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    if (params[:commit].present? && params[:commit] == "Tim kiem")
      #sap xep
      search = params[:search] if params[:search].present?
      if params[:learning_status].present?
        if params[:course_id].present? && params[:course_id] != "0"
          if params[:learning_status] == "1"
            @words = current_user.learned_words_of_course(params[:course_id].to_i)
          else
            @words = current_user.words_not_learned(params[:course_id].to_i)
          end
        else
          if params[:learning_status] == "1"
            @words = current_user.learned_words
          else
            @words = current_user.words_not_learned(params[:course_id].to_i)
            puts @words.inspect
          end
        end
      else
        if params[:course_id].present? && params[:course_id] != "0"
          @course = Course.find(params[:course_id])
          @words = @course.words
        else
          @words = Word.all
        end
      end
      if params[:order].present?
        if params[:order] == "desc"
          @words = @words.sort_by { |a| a[:word] }.reverse
        else
          @words = @words.sort_by { |a| a[:word] }
        end
      end #het sap xep
      @pagy_a, @words = pagy_array(@words, items: 4)
    else
      @words = Word.all
    end
    @pagy_a, @words = pagy_array(@words, items: 4)
    # @words = @words.paginate(page: params[:page], per_page: 10)

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
    search = params[:search] if params[:search].present?
    if params[:learning_status].present?
      if params[:course_id].present? && params[:course_id] != 0
        @words = current_user.learned_words_of_course(params[:course_id])
      else
        @words = current_user.learned_words
      end
    else
      if params[:course_id].present? && params[:course_id] != 0
        @course = Course.find(params[:course_id])
        @words = @course.words
      else
        @words = Word.all
      end
    end

    if params[:order].present?
      if params[:order] == "desc"
        @words = @words.sort_by { |a| a[:word] }.reverse
      else
        @words = @words.sort_by { |a| a[:word] }
      end
    end
  end

  private

  #yêu cầu có :word trong params và chỉ cho phép nhận các param sau
  def word_params
    params.require(:word).permit(:word, :pronounce, :word_type, :meaning, :image)
  end
end
