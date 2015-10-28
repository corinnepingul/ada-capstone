module ApplicationHelper
  def flash_message_margin(session_id)
    session_id ? "flash_message_margin" : ""
  end
end
