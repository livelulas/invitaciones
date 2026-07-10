class Invitation::GuestName < Bridgetown::Component
  def initialize(invitation:, label: nil, default: nil)
    @invitation = invitation
    @label = label || "Esta invitación es para"
    @default = default || "Nuestra familia y amigos"
  end

  attr_reader :invitation, :label, :default
end
