class StaticPagesController < ApplicationController
  def home
    @courses = Course.all.paginate(page: params[:page], per_page: 4)
  end

  def help
  end
end
