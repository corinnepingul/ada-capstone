class WelcomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @moments = @user.moments.reverse
    @homepage = "homepage"
  end

  private

  def set_user
    @user = User.find(session[:id])
  end
end
