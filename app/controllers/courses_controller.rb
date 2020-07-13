class CoursesController < ApplicationController
  def show
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

  private

  def course_params
    params.require(:course).permit(:course_name, :category_id, :image)
  end
end
