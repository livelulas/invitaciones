require "fileutils"
require_relative "../invitation/calendar"

class Builders::CalendarBuilder < SiteBuilder
  def build
    hook :site, :post_write do |site|
      generate_calendar_files(site)
    end
  end

  private

  def generate_calendar_files(site)
    invitations = site.data.invitations
    return unless invitations

    invitations.each do |slug, invitation|
      ics_content = Invitation::Calendar.generate_ics(invitation, slug: slug.to_s)
      next if ics_content.nil? || ics_content.empty?

      slug_dir = File.join(site.dest, slug.to_s)
      FileUtils.mkdir_p(slug_dir)
      File.write(File.join(slug_dir, "save-the-date.ics"), ics_content)

      next unless Invitation::Calendar::SUBDOMAIN_ROOT_SLUGS.include?(slug.to_s)

      File.write(File.join(site.dest, "save-the-date.ics"), ics_content)
    end
  end
end
