class ApiController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_verfied_user
  skip_before_filter :set_locale
  skip_before_action :verify_authenticity_token

  # TWILIO's POST REQUEST FOR SMS:
  # params => {"ToCountry"=>"US", "ToState"=>"LA", "SmsMessageSid"=>"SM67b107936f3a02e9c75c4f9b048ede91",
  # "NumMedia"=>"0", "ToCity"=>"NEW ORLEANS", "FromZip"=>"98104", "SmsSid"=>"SM67b107936f3a02e9c75c4f9b048ede91",
  # "FromState"=>"WA", "SmsStatus"=>"received", "FromCity"=>"SEATTLE", "Body"=>"Yo", "FromCountry"=>"US",
  # "To"=>"+15043157972", "ToZip"=>"70149", "NumSegments"=>"1", "MessageSid"=>"SM67b107936f3a02e9c75c4f9b048ede91",
  # "AccountSid"=>"AC6298a5335759e854332607f3a69bf92e", "From"=>"+12064997650", "ApiVersion"=>"2010-04-01",
  # "controller"=>"api", "action"=>"received_message"}

  # TWILIO's POST REQUEST FOR MMS:
  # {"ToCountry"=>"US", "MediaContentType0"=>"image/jpeg", "ToState"=>"LA",
  # "SmsMessageSid"=>"MMa39e75e57c740de6c997237fc13a0582", "NumMedia"=>"1",
  # "ToCity"=>"NEW ORLEANS", "FromZip"=>"98104", "SmsSid"=>"MMa39e75e57c740de6c997237fc13a0582",
  # "FromState"=>"WA", "SmsStatus"=>"received", "FromCity"=>"SEATTLE", "Body"=>"", "FromCountry"=>"US",
  # "To"=>"+15043157972", "ToZip"=>"70149", "NumSegments"=>"1", "MessageSid"=>"MMa39e75e57c740de6c997237fc13a0582",
  # "AccountSid"=>"AC6298a5335759e854332607f3a69bf92e", "From"=>"+12064997650",
  # "MediaUrl0"=>"https://api.twilio.com/2010-04-01/Accounts/AC6298a5335759e854332607f3a69bf92e/Messages/MMa39e75e57c740de6c997237fc13a0582/Media/ME3952542eb62296b2fbefb42bd894b3f5",
  # "ApiVersion"=>"2010-04-01", "controller"=>"api", "action"=>"received_message"}

  # TWILIO's POST REQUEST FOR BOTH SMS & MMS:
  # {"ToCountry"=>"US", "MediaContentType0"=>"image/jpeg", "ToState"=>"LA",
  # "SmsMessageSid"=>"MM16759f9b03d21d92d83572f150b77067", "NumMedia"=>"1", "ToCity"=>"NEW ORLEANS",
  # "FromZip"=>"98104", "SmsSid"=>"MM16759f9b03d21d92d83572f150b77067", "FromState"=>"WA",
  # "SmsStatus"=>"received", "FromCity"=>"SEATTLE", "Body"=>"Another pic yay", "FromCountry"=>"US",
  # "To"=>"+15043157972", "ToZip"=>"70149", "NumSegments"=>"1", "MessageSid"=>"MM16759f9b03d21d92d83572f150b77067",
  # "AccountSid"=>"AC6298a5335759e854332607f3a69bf92e", "From"=>"+12064997650",
  # "MediaUrl0"=>"https://api.twilio.com/2010-04-01/Accounts/AC6298a5335759e854332607f3a69bf92e/Messages/MM16759f9b03d21d92d83572f150b77067/Media/ME44d29624ce5b6bca3fcb4c0e8254c165",
  # "ApiVersion"=>"2010-04-01", "controller"=>"api", "action"=>"received_message"}

  def received_message
    moment = parse_message(params)

    # Finds the user who's sending in the text (may need to parse this data)
    user = find_user_by_phone_number(moment[:user_phone_number])

    # If the user is found, create a new moment for them
    if user.nil?
      # TODO: Error Handling
      puts "user is nil"
    else
      puts "ready to create moment"
      puts moment
      # IS IT AN SMS OR MMS?
      create_moment(user, moment)
    end
  end

  private

  def parse_message(params) # this currently only works with one photo
    moment = {
      body: params["Body"],
      user_phone_number: params["From"],
      media_url: nil
    }

    # Assigns media url if it exists
    if params["MediaUrl0"]
      moment[:media_url] = params["MediaUrl0"]
    end

    return moment
  end

  def find_user_by_phone_number(phone_number)
    # without the .first, this returns an Active Record relation
    # with the .first, this returns the User object
    User.where(phone_number: phone_number).first
  end

  def create_moment(user, moment_info)
    date = Date.today

    new_moment = Moment.new(
              date: date,
              body: moment_info[:body],
              user_id: user.id
              # media_url: moment_info[:media_url]
            )

    if new_moment.save
      puts "This new_moment was saved!"
    end
  end
end
