class ApiController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_verfied_user
  skip_before_filter :set_locale
  skip_before_action :verify_authenticity_token

  # TWILIO's POST REQUEST:
  # params => {"ToCountry"=>"US", "ToState"=>"LA", "SmsMessageSid"=>"SM67b107936f3a02e9c75c4f9b048ede91",
  # "NumMedia"=>"0", "ToCity"=>"NEW ORLEANS", "FromZip"=>"98104", "SmsSid"=>"SM67b107936f3a02e9c75c4f9b048ede91",
  # "FromState"=>"WA", "SmsStatus"=>"received", "FromCity"=>"SEATTLE", "Body"=>"Yo", "FromCountry"=>"US",
  # "To"=>"+15043157972", "ToZip"=>"70149", "NumSegments"=>"1", "MessageSid"=>"SM67b107936f3a02e9c75c4f9b048ede91",
  # "AccountSid"=>"AC6298a5335759e854332607f3a69bf92e", "From"=>"+12064997650", "ApiVersion"=>"2010-04-01",
  # "controller"=>"api", "action"=>"received_message"}

  def received_message
    message_body = params["Body"]
    from_number = params["From"]

    # finds the user who's sending in the text (may need to parse this data)
    @user = User.where(phone_number: from_number).first

    # if the user is found, create a new moment for them
    if @user.nil?
      puts "User is nil :("
    else
      @moment = Moment.new(date: Date.new, body: message_body, user_id: user.id)

      if @moment.save
        puts "This moment was saved!"
      end
    end

  end
end
