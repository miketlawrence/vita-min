module Ctc
  module Questions
    class RoutingNumberController < QuestionsController
      # TODO: Transition to Authenticated once we log in client
      include AnonymousIntakeConcern

      layout "intake"

      def self.show?(intake)
        intake.refund_payment_method_direct_deposit?
      end

      private

      def illustration_path
        "bank-details.svg"
      end
    end
  end
end