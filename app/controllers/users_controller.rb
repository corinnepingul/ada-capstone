require 'authy_client'

class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:create, :show_verify]
  skip_before_filter :require_verfied_user, only: [:create, :show_verify, :verify, :resend]

  def create
    user_attributes = valid_user_params

    # Adds US country code to user_attributes (1)
    user_attributes[:country_code] = "1"

    # this changes the phone_number field to delete any "-", " ", or "." characters
    # and adds country code to the front
    format_phone_number(user_attributes)

    user = User.new(user_attributes)

    if user.save
      session[:id] = user.id
      register_authy_user(user)
      # send_verification_code_to_current_user
      flash[:message] = MESSAGES[:needs_verification]

      redirect_to verify_path
    else
      flash.now[:errors] = ERRORS[:registration_error]

      render "sessions/new"
    end
  end

  def show_verify
    # if there's no user logged in, redirect to registration path
    return redirect_to registration_path unless session[:id]

    user = User.find(session[:id])
    @user_phone_number = user.phone_number
  end

  def verify
    user = current_user

    # Use Authy to send the verification token to API
    token = AuthyClient.verify_token(user.authy_id, params[:token])

    if token.ok?
      # Mark the user as verified
      user.update(verified: true)
      flash[:message] = MESSAGES[:successful_login]

      redirect_to root_path
    else
      flash.now[:danger] = ERRORS[:incorrect_verification_code]

      render :show_verify
    end
  end

  def resend
    send_verification_code_to_current_user
    flash[:notices] = NOTICES[:verification_code_resent]

    redirect_to verify_path
  end

  private

  def send_verification_code_to_current_user
    user = current_user

    # Send an SMS with verifcation code to user, see authy_client.rb
    AuthyClient.send_verification_code(user.authy_id)
  end

  def register_authy_user(user)
    # Registers the user in Authy (to send them a text), see authy_client.rb
    authy = AuthyClient.register_user(user)

    # Updates authy_id for user record
    user.update(authy_id: authy.id)
  end

  def valid_user_params
    params.require(:user).permit(
                            :username,
                            :email,
                            :phone_number,
                            :password,
                            :password_confirmation,
                            :locale
                            )
  end

  def format_phone_number(user_attributes)
    # gets rid of delimitors
    user_attributes[:phone_number].gsub!(/[\.]/, "")
    user_attributes[:phone_number].gsub!(/[\-]/, "")
    user_attributes[:phone_number].gsub!(/[\ ]/, "")

    # this changes phone_number field to include country code before saving record
    user_attributes[:phone_number] = "+" + user_attributes[:country_code] + user_attributes[:phone_number]
  end
end
