class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login
  before_action :require_verfied_user

  MESSAGES = {
    successful_signup: { successful_signup: "You have signed up!"},
    successful_login: { successful_login: "You have logged in!" },
    successful_logout: { successful_logout: "You have logged out!" }
  }

  ERRORS = {
    not_logged_in: { not_logged_in: "Please log in to see this page." },
    login_error: { login_error: "Invalid log in. Please try again!" },
    registration_error: { registration_error: "Invalid fields. Please try again." },
    incorrect_verification_code: { incorrect_verification_code: "Incorrect code, please try again." }
  }

  NOTICES = {
    verification_code_resent: { verification_code_resent: "Verification code has been resent to your phone." },
    needs_verification: { needs_verification: "Please verify your account. A verification code has been resent to your phone." }
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

  def require_verfied_user
    @user = current_user
    redirect_to verify_path if @user.verified == false
  end

  def current_user
    return unless session[:id]
    @current_user ||= User.find(session[:id])
  end
end
