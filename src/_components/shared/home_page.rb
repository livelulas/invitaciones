class Shared::HomePage < Bridgetown::Component
  def initialize(site:, metadata:)
    @metadata = metadata
  end

  attr_reader :metadata
end
