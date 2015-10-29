class MomentsController < ApplicationController

  def search
    raise # what are my params here

    # build psql statement here
    # select * from moments where user_id = 2 and body like '%things%' and body like '%friend%';
    # user_moments = User.find(session[:id]).moment
  end

end
