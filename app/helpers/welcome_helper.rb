module WelcomeHelper
  def formatted_date(date)
    return DateTime.parse(date).strftime('%b %d, %Y')
  end

  def moment_position_class_assignment(index)
    index % 2 == 0 ? "cd-left" : "cd-right"
  end

  def moment_color_class_assignment(index)
    if index % 4 == 0
      color = "color-orange"
    elsif index % 4 == 1
      color = "color-red"
    elsif index % 4 == 2
      color = "color-blue"
    elsif index % 4 == 3
      color = "color-green"
    end
  end

  def moment_date_color_class_assignment(index)
    if index % 4 == 0
      color = "color-light-orange"
    elsif index % 4 == 1
      color = "color-light-red"
    elsif index % 4 == 2
      color = "color-light-blue"
    elsif index % 4 == 3
      color = "color-light-green"
    end
  end
end
