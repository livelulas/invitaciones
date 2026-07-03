class Invitation::Page < Bridgetown::Component
  SECTION_ORDER = %w[
    hero story parents gallery schedule location lodging details gift
  ].freeze

  SECTION_COMPONENTS = {
    "hero" => Invitation::Hero,
    "story" => Invitation::Story,
    "intro" => Invitation::IntroMessage,
    "countdown" => Invitation::Countdown,
    "parents" => Invitation::Parents,
    "gallery" => Invitation::Gallery,
    "schedule" => Invitation::Schedule,
    "location" => Invitation::LocationButtons,
    "lodging" => Invitation::Lodging,
    "details" => Invitation::Details,
    "gift" => Invitation::Gift
  }.freeze

  def initialize(invitation:, slug:)
    @invitation = invitation
    @slug = slug
  end

  attr_reader :invitation, :slug

  def enabled_sections
    SECTION_ORDER.filter_map do |key|
      config = section_config(key)
      next unless section_enabled?(config)

      [key, config]
    end
  end

  private

  def section_config(key)
    sections = @invitation.sections
    return unless sections

    sections[key] || sections[key.to_sym]
  end

  def section_enabled?(config)
    return false unless config

    value = config.respond_to?(:enabled) ? config.enabled : config[:enabled]
    value != false
  end
end
