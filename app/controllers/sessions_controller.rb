class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  skip_before_filter :require_verfied_user, only: [:new, :create, :destroy]
  before_action :set_user, only: [:create]

  def new
    @user = User.new
  end

  def create
    # checks if user has signed up
    if @user && @user.authenticate(params[:session][:password])
      session[:id] = @user.id

      # checks if user has verified their account using phone code
      if @user.verified == true
        flash[:messages] = MESSAGES[:successful_login]

        redirect_to root_path(@user)
      else
        flash[:notice] = NOTICES[:needs_verification]

        redirect_to verify_path
      end

    else
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
end
