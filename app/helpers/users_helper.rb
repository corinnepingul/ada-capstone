module UsersHelper
  def format_phone_number_for_display(phone_number)
    return  "(" + phone_number[2..4] + ") " + phone_number[5..7] + "-" + phone_number[8..11]
  end
end
