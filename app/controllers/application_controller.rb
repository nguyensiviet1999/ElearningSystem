class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend
  before_action :set_search

  def set_search
    @q = Word.ransack(params[:q])
    @words = @q.result
  end
end

# Your Client ID:1034385630020-9auir9964t23q61jsfqm17jrca4ve4i0.apps.googleusercontent.com
# Your Client Secret:SExvN7P511PuVe7ry-lua4dc
