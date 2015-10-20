class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:create, :show_verify]
  skip_before_filter :require_verfied_user, only: [:create, :show_verify, :verify]


  def create
    @user = User.new(valid_user_params)

    if @user.save
      session[:id] = @user.id
      register_authy_user(@user)

      redirect_to verify_path
    else
      flash.now[:errors] = ERRORS[:registration_error]

      render "sessions/new"
    end
  end

  def show_verify
    # if there's no user logged in, redirect to registration path
    return redirect_to registration_path unless session[:id]

    # otherwise, send them a code
    @user = current_user

    # Send an SMS with verifcation code to user
    Authy::API.request_sms(id: @user.authy_id, force: true)
  end

  def verify
    @user = current_user

    # Use Authy to send the verification token to API
    token = Authy::API.verify(id: @user.authy_id, token: params[:token])

    if token.ok?
      # Mark the user as verified
      @user.update(verified: true)
      flash[:message] = MESSAGES[:successful_login]

      redirect_to root_path
    else
      flash.now[:danger] = ERRORS[:incorrect_verification_code]

      render :show_verify
    end
  end

  def resend
    @user = current_user
    Authy::API.request_sms(id: @user.authy_id, force: true)
    flash[:notices] = NOTICES[:verification_code_resent]

    redirect_to verify_path
  end

  private

  def register_authy_user(user)
    # registers the user in Authy (to send them a text)
    authy = Authy::API.register_user(
      email: user.email,
      cellphone: user.phone_number,
      country_code: user.country_code
    )
    user.update(authy_id: authy.id)
  end

  def valid_user_params
    params.require(:user).permit(:username, :email, :phone_number, :country_code, :password, :password_confirmation, :locale)
  end
end
