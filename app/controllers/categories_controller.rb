class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Them thanh cong"
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name_category)
  end
end
