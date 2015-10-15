class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :create]
  before_action :set_user, only: [:create]

  def index
    @user = User.new
  end

  def create # STOPPED HERE!
    if @user && @user.authenticate(params[:session][:password])
      session[:id] = @user.id
      flash[:messages] = MESSAGES[:successful_login]
      redirect_to root_path(@user)
    else
      flash.now[:errors] = ERRORS[:login_error]
      render :index
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
