class UsersController < ApplicationController
  skip_before_filter :require_login, only: [ :create]


  def create
    @user = User.new(valid_user_params)

    if @user.save
      session[:id] = @user.id
      redirect_to root_path
    else
      flash[:errors] = ERRORS[:registration_error]
      redirect_to registration_path
    end
  end

  private

  def valid_user_params
    params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation, :locale)
  end
end
