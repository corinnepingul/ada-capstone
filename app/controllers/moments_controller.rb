class MomentsController < ApplicationController
  def search
    @moments = Moment.user(session[:id]).search_body(params[:search_term]).sort_by(&:created_at)
    @homepage = @moments.empty? ? "empty-search" : "homepage"
  end
end
