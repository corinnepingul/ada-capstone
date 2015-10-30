class WelcomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @homepage = "homepage"
    @years_array = users_years(@user)
    @year = params[:year] || Date.today.year.to_s

    if params[:year] # loads moments from selected year
      @moments = Moment.user(session[:id]).year(params[:year]).reverse
      render partial: "welcome/timeline"
    else # default only loads moments from the current year
      @moments = Moment.user(session[:id]).current_year.reverse
      @homepage = @moments.empty? ? "empty-search" : "homepage"
      render :index
    end
  end

  private

  def set_user
    @user = User.find(session[:id])
  end

  def users_years(user)
    # signup_year = user.created_at.year
    signup_year = 2001
    current_year = Date.today.year

    year_array = []

    year_counter = current_year
    while year_counter >= signup_year
      year_array.push(year_counter.to_s)
      year_counter -= 1
    end

    return year_array
  end
end
