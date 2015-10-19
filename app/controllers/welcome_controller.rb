class WelcomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    # redirect_to registration if @user.verified == false ?
    @moments = @user.moments
  end

  private

  def set_user
    @user = User.find(session[:id])
  end
end
