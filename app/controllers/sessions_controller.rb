class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  skip_before_filter :require_verfied_user, only: [:new, :create, :destroy]
  before_action :set_user, only: [:create]

  def new
    redirect_to root_path if session[:id]
    @user = User.new
  end

  def create
    # If user is signed up AND verified:
    if user_is_signed_up(@user) && @user.verified
      session[:id] = @user.id
      flash[:messages] = MESSAGES[:successful_login]

      redirect_to root_path(@user)

    # If user is signed up AND NOT verified:
    elsif user_is_signed_up(@user)
      session[:id] = @user.id
      flash[:notice] = NOTICES[:needs_verification]

      redirect_to verify_path

    # If user is NOT signed up AND NOT verified:
    elsif
      flash[:errors] = ERRORS[:login_error]
      redirect_to registration_path
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by(username: params[:session][:username])
  end

  def user_is_signed_up(user)
    user && user.authenticate(params[:session][:password])
  end
end
