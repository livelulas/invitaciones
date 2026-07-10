class Invitation::Story < Invitation::BaseSection
  def story_date_lines
    date = invitation.date
    return [] unless date

    time = Time.parse(date.to_s)
    if language.start_with?("en")
      [month_names[time.month], time.day.to_s, time.year.to_s]
    else
      ["#{time.day} de", month_names[time.month].capitalize, time.year.to_s]
    end
  rescue ArgumentError
    []
  end

  def story_content
    content_data
  end
end
