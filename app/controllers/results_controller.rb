class ResultsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    current_user.join_to_course(@course)
    redirect_to @course
  end

  def destroy
  end
end
