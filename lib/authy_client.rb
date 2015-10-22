class AuthyClient
  def self.register_user(user)
    Authy::API.register_user(
      email: user.email,
      cellphone: user.phone_number[-10..-1], # this takes out the country code from the phone_number
      country_code: user.country_code
    )
  end

end
