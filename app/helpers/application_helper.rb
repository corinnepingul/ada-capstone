module ApplicationHelper
  def flash_message_margin(session_id)
    session_id ? "flash_message_margin" : ""
  end

  def background_photo(session_id)
    session_id ? "boat" : "nye"
  end
end
