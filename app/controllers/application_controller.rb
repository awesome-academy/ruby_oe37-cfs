class ApplicationController < ActionController::Base
  include SessionsHelper
  include CategoriesHelper

  before_action :set_locale, :check_logged, except: [:new, :create, :edit]

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def check_logged
    return if logged_in?

    flash[:danger] = t "login.please_log_in"
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
