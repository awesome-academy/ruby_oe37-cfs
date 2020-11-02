class ApplicationController < ActionController::Base
  include SessionsHelper
  include CategoriesHelper

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden, content_type: "text/html"}
      format.html do
        redirect_to main_app.root_path, alert: exception
        .default_message = t(".access_denied_permission")
      end
      format.js{head :forbidden, content_type: "text/html"}
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def configure_permitted_parameters
    added_attrs = [:full_name, :email, :password,
      :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
