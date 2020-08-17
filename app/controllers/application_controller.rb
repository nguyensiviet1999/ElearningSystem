class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend
  before_action :set_search
  before_action :set_locale

  def set_search
    @q = Word.ransack(params[:q])
    @words = @q.result
  end

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
end

# Your Client ID:1034385630020-9auir9964t23q61jsfqm17jrca4ve4i0.apps.googleusercontent.com
# Your Client Secret:SExvN7P511PuVe7ry-lua4dc
