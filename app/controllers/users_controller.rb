class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:create, :show_verify]
  skip_before_filter :require_verfied_user, only: [:create, :show_verify, :verify]


  def create
    @user = User.new(valid_user_params)

    if @user.save
      session[:id] = @user.id

      # registers the user in Authy (to send them a text)
      authy = Authy::API.register_user(
        email: @user.email,
        cellphone: @user.phone_number,
        country_code: @user.country_code
      )
      @user.update(authy_id: authy.id)

      redirect_to verify_path
    else
      flash[:errors] = ERRORS[:registration_error]
      redirect_to registration_path
    end
  end

  def show_verify
    @user = current_user
    # raise

    # Send an SMS to user
    Authy::API.request_sms(id: @user.authy_id, force: true)

    return redirect_to registration_path unless session[:id]
  end

  def verify
    @user = current_user

    # Use Authy to send the verification token
    token = Authy::API.verify(id: @user.authy_id, token: params[:token])

    if token.ok?
      # Mark the user as verified for get /user/:id
      @user.update(verified: true)

      # Show the homepage
      redirect_to root_path
    else
      flash.now[:danger] = "Incorrect code, please try again"
      render :show_verify
    end
  end

  def resend
    @user = current_user
    Authy::API.request_sms(id: @user.authy_id, force: true)
    flash[:notice] = { notice: "Verification code re-sent" }
    redirect_to verify_path
  end

  private

  def valid_user_params
    params.require(:user).permit(:username, :email, :phone_number, :country_code, :password, :password_confirmation, :locale)
  end
end
