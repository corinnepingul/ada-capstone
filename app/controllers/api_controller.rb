class ApiController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_verfied_user
end
