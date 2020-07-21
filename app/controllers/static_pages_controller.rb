class StaticPagesController < ApplicationController
  def home
    @courses = Course.all.paginate(page: params[:page], per_page: 4)
    @ranking_user = Array.new
    User.all.each { |user|
      user_data = Hash.new
      user_data[:user] = user
      user_data[:learned_words_count] = user.learned_words.count
      @ranking_user.push(user_data)
    }
    @ranking_user = @ranking_user.sort_by { |a| a[:learned_words_count] }
    puts @ranking_user
  end

  def help
  end
end
