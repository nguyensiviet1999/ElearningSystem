class UserLearnedWordsController < ApplicationController
  before_action :logged_in_user

  def destroy
    word = Word.find(params[:id])
    if current_user.learned_words.include?(word)
      current_user.unlearned_word(word)
    end
  end
end
