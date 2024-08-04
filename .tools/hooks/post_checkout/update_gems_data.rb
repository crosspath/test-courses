# frozen_string_literal: true

# Run after updating this file:
#   bin/overcommit --sign post-checkout
module Overcommit::Hook::PostCheckout
  # Update databases for bundle-audit, bundle-leak.
  class UpdateGemsData < Base
    def run
      result = execute("bin/bundle-leak update && bin/bundle-audit update")
      return :fail, result.stdout unless result.success?

      :pass
    end
  end
end
