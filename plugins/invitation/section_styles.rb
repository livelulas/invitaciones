module Invitation
  module SectionStyles
    def section_style(section_config, invitation:, default_bg: :bg, default_text: :text)
      colors = invitation.theme.colors
      config = normalize_section_config(section_config)

      bg = config[:background_color]
      bg = colors[default_bg] if bg.nil? || bg.to_s.empty?

      text = config[:text_color]
      text = colors[default_text] if text.nil? || text.to_s.empty?

      "--section-bg: #{bg}; --section-text: #{text};"
    end

    def section_background_image(section_config)
      config = normalize_section_config(section_config)
      image = config[:background_image]
      return if image.nil? || image.to_s.empty?

      image
    end

    def default_bg_for(section_key)
      case section_key.to_s
    when "story", "intro", "countdown", "schedule", "parents", "details"
      :bg_alt
    when "gallery", "gift", "location"
      :bg_dark
      else
        :bg
      end
    end

    private

    def normalize_section_config(section_config)
      return {} if section_config.nil?

      section_config.respond_to?(:to_h) ? section_config.to_h.transform_keys(&:to_sym) : {}
    end
  end
end
