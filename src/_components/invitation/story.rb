class Invitation::Story < Invitation::BaseSection
  def story_date_lines
    date = invitation.date
    return [] unless date

    time = Time.parse(date.to_s)
    ["#{time.day} de", SPANISH_MONTHS[time.month].capitalize, time.year.to_s]
  rescue ArgumentError
    []
  end

  def story_content
    content_data
  end
end
