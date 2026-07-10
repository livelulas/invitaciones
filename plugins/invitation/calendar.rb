require "cgi"
require "uri"
require "time"

module Invitation; end

module Invitation::Calendar
  SUBDOMAIN_ROOT_SLUGS = %w[elena-armando].freeze
  SLUG_ICS_PATHS = {
    "elena-armando-en" => "/elena-armando/en/save-the-date.ics"
  }.freeze

  module_function

  def event_start(invitation)
    date = read(invitation, :date)
    return unless date

    Time.parse(date.to_s)
  rescue ArgumentError
    nil
  end

  def event_end(invitation)
    start = event_start(invitation)
    return unless start

    hours = read_calendar(invitation, :duration_hours)&.to_i
    hours = 8 if hours.nil? || hours <= 0
    start + (hours * 3600)
  end

  def google_calendar_url(invitation)
    start = event_start(invitation)
    finish = event_end(invitation)
    return unless start && finish

    params = {
      action: "TEMPLATE",
      text: event_title(invitation),
      dates: "#{format_google_time(start)}/#{format_google_time(finish)}",
      details: event_description(invitation),
      location: event_location(invitation)
    }

    "https://calendar.google.com/calendar/render?#{URI.encode_www_form(params)}"
  end

  def ics_path(invitation)
    slug = read(invitation, :slug).to_s
    return SLUG_ICS_PATHS[slug] if SLUG_ICS_PATHS.key?(slug)
    return "/save-the-date.ics" if SUBDOMAIN_ROOT_SLUGS.include?(slug)

    "/#{slug}/save-the-date.ics"
  end

  def generate_ics(invitation, slug: nil)
    start = event_start(invitation)
    finish = event_end(invitation)
    return unless start && finish

    uid_slug = slug || read(invitation, :slug) || "event"
    uid = "#{uid_slug}@livelulas.com"
    now = Time.now.utc.strftime("%Y%m%dT%H%M%SZ")

    lines = [
      "BEGIN:VCALENDAR",
      "VERSION:2.0",
      "PRODID:-//Livelulas//Invitations//ES",
      "CALSCALE:GREGORIAN",
      "METHOD:PUBLISH",
      "BEGIN:VEVENT",
      "UID:#{uid}",
      "DTSTAMP:#{now}",
      "DTSTART:#{format_ics_time(start)}",
      "DTEND:#{format_ics_time(finish)}",
      "SUMMARY:#{escape_ics(event_title(invitation))}",
      "DESCRIPTION:#{escape_ics(event_description(invitation))}",
      "LOCATION:#{escape_ics(event_location(invitation))}",
      "END:VEVENT",
      "END:VCALENDAR"
    ]

    "#{lines.join("\r\n")}\r\n"
  end

  def event_title(invitation)
    read_calendar(invitation, :title) ||
      read(invitation, :seo, :title) ||
      "Boda #{read(invitation, :title)}"
  end

  def event_description(invitation)
    read_calendar(invitation, :description) ||
      read(invitation, :seo, :description) ||
      ""
  end

  def event_location(invitation)
    read_calendar(invitation, :location) ||
      read(invitation, :content, :hero, :venue) ||
      ""
  end

  def read_calendar(invitation, key)
    calendar = read(invitation, :calendar)
    return unless calendar

    read(calendar, key)
  end

  def read(object, *keys)
    keys.reduce(object) do |memo, key|
      break nil if memo.nil?

      if memo.respond_to?(key)
        memo.public_send(key)
      elsif memo.respond_to?(:[])
        memo[key] || memo[key.to_s]
      end
    end
  end

  def format_google_time(time)
    time.strftime("%Y%m%dT%H%M%S")
  end

  def format_ics_time(time)
    time.utc.strftime("%Y%m%dT%H%M%SZ")
  end

  def escape_ics(value)
    value.to_s
      .gsub("\\", "\\\\")
      .gsub(";", "\\;")
      .gsub(",", "\\,")
      .gsub("\n", "\\n")
  end
end
