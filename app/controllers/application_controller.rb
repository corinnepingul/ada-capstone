class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login

  MESSAGES = {
    successful_signup: { successful_signup: "You have signed up!"},
    successful_login: { successful_login: "You have logged in!" },
    successful_logout: { successful_logout: "You have logged out!" }
  }

  ERRORS = {
    not_logged_in: { not_logged_in: "Please log in to see this page." },
    login_error: { login_error: "Invalid log in. Please try again!" },
    registration_error: { registration_error: "Invalid fields. Please try again." }
  }

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def require_login
    # this session[:id] = nil is for resetting the session if I delete a user
    # record without logging out first!
    # session[:id] = nil
    if session[:id].nil?
      redirect_to registration_path unless session[:id]
    end
  end

  def current_user
    return unless session[:id]
    @current_user ||= User.find(session[:id])
  end
end
