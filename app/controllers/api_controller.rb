class ApiController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_verfied_user
  skip_before_filter :set_locale

  def received_message
    puts "hello"
    puts request.body

    message_body = params["Body"]
    from_number = params["From"]

    # finds the user who's sending in the text (may need to parse this data)
    user = User.where(phone_number: from_number)

    # if the user is found, create a new moment for them
    unless user.nil?
      @moment = Moment.create(
                  date: Date.new,
                  body: message_body,
                  user_id: user.id
                  )
    end
  end
end
