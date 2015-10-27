class AuthyClient
  def self.register_user(user)
    Authy::API.register_user(
      email: user.email,
      cellphone: user.phone_number[-10..-1], # this takes out the country code from the phone_number
      country_code: user.country_code
    )
  end

  def self.send_verification_code(authy_id)
    puts "I made it to the Authy client."
    authy = Authy::API.request_sms(id: authy_id, force: true)
    print "Here are the authy errors: "
    puts authy.errors
  end

  def self.verify_token(authy_id, token)
    Authy::API.verify(id: authy_id, token: token)
  end
end
