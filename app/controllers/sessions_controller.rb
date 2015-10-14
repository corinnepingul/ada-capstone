class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :create]

  def index; end
end
