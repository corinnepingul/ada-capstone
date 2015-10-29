class MomentsController < ApplicationController

  def search
    @moments = Moment.user(session[:id]).search_body(params[:search_term])
    @homepage = "homepage"

    render "welcome/index"
  end
end
