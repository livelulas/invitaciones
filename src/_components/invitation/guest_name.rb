class Invitation::GuestName < Bridgetown::Component
  def initialize(invitation:, label: nil)
    @invitation = invitation
    @label = label || "Esta invitación es para"
  end

  attr_reader :invitation, :label
end
