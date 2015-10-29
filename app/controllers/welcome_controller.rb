class WelcomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    # only loads moments from the current year
    @moments = Moment.user(session[:id]).current_year.reverse

    @homepage = "homepage"
    @years = users_years(@user)
  end

  def year
    @moments = Moment.user(session[:id]).year(params[:year]).reverse

    @homepage = @moments.empty? ? "empty-search" : "homepage"
    @years = users_years(@user)

    render :index
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

    year_counter = signup_year
    while year_counter <= current_year
      year_array.push(year_counter.to_s)
      year_counter += 1
    end

    return year_array
  end

  def created_at_year(date)
  end
end
