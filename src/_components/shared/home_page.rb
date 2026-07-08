class Shared::HomePage < Bridgetown::Component
  def initialize(site:, metadata:)
    @site = site
    @metadata = metadata
  end

  attr_reader :metadata

  def invitations
    return [] unless @site.collections.invitations

    @site.collections.invitations.resources.filter_map do |resource|
      slug = resource.data.slug
      next unless slug

      invitation = @site.data.dig(:invitations, slug)
      next unless invitation

      {
        slug: slug,
        title: resource.data.title || invitation.title,
        url: resource.relative_url
      }
    end
  end
end
