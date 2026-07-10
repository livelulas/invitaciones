class Invitation::BaseSection < Bridgetown::Component
  include Invitation::SectionStyles

  def initialize(invitation:, section_config:, section_key:)
    @invitation = invitation
    @section_config = section_config
    @section_key = section_key
  end

  attr_reader :invitation, :section_config, :section_key

  def section_style_attr
    section_style(
      section_config,
      invitation: invitation,
      default_bg: default_bg_for(section_key),
      default_text: :text
    )
  end

  def section_bg_image
    section_background_image(section_config)
  end

  def content_data
    data = invitation.content
    data[section_key] || data[section_key.to_sym]
  end

  def css_class
    "invitation-#{section_key}"
  end

  def assets
    invitation.assets
  end

  def asset_url(path)
    return if path.nil? || path.to_s.empty?

    relative_url(path)
  end

  def schedule_icon_for(item)
    key = item.icon_key || item[:icon_key]
    return unless key && assets&.schedule_icons

    icons = assets.schedule_icons
    icons[key] || icons[key.to_sym]
  end

  def labels
    invitation.labels || {}
  end

  def label_for(key, fallback)
    value = labels.respond_to?(key) ? labels.public_send(key) : labels[key.to_s] || labels[key.to_sym]
    value.nil? || value.to_s.empty? ? fallback : value
  end

  def language
    invitation.respond_to?(:language) ? invitation.language.to_s : "es"
  end

  def month_names
    language.start_with?("en") ? ENGLISH_MONTHS : SPANISH_MONTHS
  end

  def formatted_hero_date
    date = invitation.date
    return date unless date

    time = Time.parse(date.to_s)
    month = month_names[time.month].upcase
    "#{month} #{time.day}, #{time.year}"
  rescue ArgumentError
    date
  end

  SPANISH_MONTHS = {
    1 => "enero", 2 => "febrero", 3 => "marzo", 4 => "abril",
    5 => "mayo", 6 => "junio", 7 => "julio", 8 => "agosto",
    9 => "septiembre", 10 => "octubre", 11 => "noviembre", 12 => "diciembre"
  }.freeze

  ENGLISH_MONTHS = {
    1 => "January", 2 => "February", 3 => "March", 4 => "April",
    5 => "May", 6 => "June", 7 => "July", 8 => "August",
    9 => "September", 10 => "October", 11 => "November", 12 => "December"
  }.freeze

  def formatted_date
    date = invitation.date
    return date unless date

    time = Time.parse(date.to_s)
    month = month_names[time.month].upcase
    language.start_with?("en") ? "#{month} #{time.day}, #{time.year}" : "#{time.day} DE #{month} #{time.year}"
  rescue ArgumentError
    date
  end

  def formatted_date_short
    date = invitation.date
    return date unless date

    time = Time.parse(date.to_s)
    language.start_with?("en") ? "#{month_names[time.month]} #{time.day}, #{time.year}" : "#{time.day} de #{month_names[time.month]} #{time.year}"
  rescue ArgumentError
    date
  end

  def formatted_rsvp_deadline
    deadline = invitation.rsvp_deadline
    return deadline unless deadline

    time = Time.parse(deadline.to_s)
    language.start_with?("en") ? "#{month_names[time.month]} #{time.day}" : "#{time.day} de #{month_names[time.month]}"
  rescue ArgumentError
    deadline
  end

  def calendar_url
    return unless Invitation::Calendar.event_start(invitation)

    custom_url = content_data&.calendar_url || content_data&.save_url
    return custom_url if custom_url && !custom_url.to_s.empty?

    calendar_google_url
  end

  def calendar_google_url
    Invitation::Calendar.google_calendar_url(invitation)
  end

  def calendar_webcal_url
    path = Invitation::Calendar.ics_path(invitation)
    absolute_url(path).sub(/\Ahttps?:\/\//i, "webcal://")
  end
end
