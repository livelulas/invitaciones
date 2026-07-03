class Builders::InvitationsBuilder < SiteBuilder
  def build
    generator :attach_invitation_data
  end

  def attach_invitation_data
    return unless site.collections.invitations

    site.collections.invitations.resources.each do |resource|
      slug = resource.data.slug
      next unless slug

      invitation = site.data.dig(:invitations, slug)
      next unless invitation

      resource.data.invitation = invitation
    end
  end
end
