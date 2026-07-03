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

  def formatted_hero_date
    date = invitation.date
    return date unless date

    time = Time.parse(date.to_s)
    month = SPANISH_MONTHS[time.month].upcase
    "#{month} #{time.day}, #{time.year}"
  rescue ArgumentError
    date
  end

  SPANISH_MONTHS = {
    1 => "enero", 2 => "febrero", 3 => "marzo", 4 => "abril",
    5 => "mayo", 6 => "junio", 7 => "julio", 8 => "agosto",
    9 => "septiembre", 10 => "octubre", 11 => "noviembre", 12 => "diciembre"
  }.freeze

  def formatted_date
    date = invitation.date
    return date unless date

    time = Time.parse(date.to_s)
    month = SPANISH_MONTHS[time.month].upcase
    "#{time.day} DE #{month} #{time.year}"
  rescue ArgumentError
    date
  end

  def formatted_date_short
    date = invitation.date
    return date unless date

    time = Time.parse(date.to_s)
    "#{time.day} de #{SPANISH_MONTHS[time.month]} #{time.year}"
  rescue ArgumentError
    date
  end

  def formatted_rsvp_deadline
    deadline = invitation.rsvp_deadline
    return deadline unless deadline

    time = Time.parse(deadline.to_s)
    "#{time.day} de #{SPANISH_MONTHS[time.month]}"
  rescue ArgumentError
    deadline
  end
end
